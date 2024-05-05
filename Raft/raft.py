import sys

import Pyro5.api
import threading
import random
import time

# Constants
ELECTION_TIMEOUT = (10, 20)  # Random election timeout range in seconds
HEARTBEAT_INTERVAL = 1/10      # Interval for leader to send heartbeat
MAJORITY = 3               # Majority required for log entry commit

peers = [{"node_id": "node_1", "port": 8001},
            {"node_id": "node_2", "port": 8002},
            {"node_id": "node_3", "port": 8003},
            {"node_id": "node_4", "port": 8004}]

# Raft Node

class RaftNode:
    def __init__(self, node_id, port):
        self.node_id = node_id
        self.port = port
        self.state = "follower"
        self.current_term = 0
        self.voted = False
        self.voted_for = None
        self.message = None
        self.uncommitted_msg = None
        self.election_timer = None
        self.heartbeat_timer = None

    def start_election_timer(self):
        if self.election_timer is not None:
            self.election_timer.cancel()
        timeout = random.uniform(*ELECTION_TIMEOUT)
        self.election_timer = threading.Timer(timeout, self.start_election)
        self.election_timer.start()

    def start_heartbeat_timer(self):
        if self.heartbeat_timer is not None:
            self.heartbeat_timer.cancel()
        self.heartbeat_timer = threading.Timer(HEARTBEAT_INTERVAL, self.send_heartbeat)
        self.heartbeat_timer.start()

    @Pyro5.api.expose
    def sayHi(self):
        print('Hi!')
        return True

    @Pyro5.api.expose
    def request_vote(self, term, candidate_id):
        print(f"Request vote called with term={term}, current_term={self.current_term}, voted={self.voted}, voted_for={self.voted_for}")
        if term > self.current_term and not self.voted:
            self.current_term = term
            self.voted = True
            self.voted_for = candidate_id
            return True
        return False

    def start_election(self):
        self.current_term += 1
        self.state = "candidate"
        self.voted = True
        num_votes = 1
        print(f"Election started by {self.node_id}")
        for i in range(3):
            if peers[i]['node_id'] != self.node_id:
                uri_n = peers[i]
                try:
                    node_n = Pyro5.api.Proxy(f"PYRO:{uri_n['node_id']}@localhost:{uri_n['port']}")
                    #vote_granted = node_n.sayHi()
                    vote_granted = node_n.request_vote(self.current_term, self.node_id)
                except Exception:
                    print(Pyro5.errors.get_pyro_traceback())

                if vote_granted:
                    num_votes += 1

        if num_votes >= MAJORITY:
            print(f"Node {self.node_id} has been elected the leader!")
            self.become_leader()
        else:
            print(f"Election Failed!")
            self.start_election_timer()

    def become_leader(self):
        self.state = "leader"
        ns = Pyro5.api.locate_ns()
        ns.register('leader', f"PYRO:{self.node_id}@localhost:{self.port}")
        self.start_heartbeat_timer()

    @Pyro5.api.expose
    def append_entries(self, message):
        ack = 0
        if self.state == 'leader':
            self.uncommitted_msg = message
            for i in range(3):
                uri_n = peers[i]
                node_n = Pyro5.api.Proxy(f"PYRO:{uri_n['node_id']}@localhost:{uri_n['port']}")
                persisted = node_n.append_entries(message)
                if persisted:
                    ack += 1

            if ack >= MAJORITY:
                self.message = self.uncommited_msg
               # print(f"Message {message} committed to leader {self.node_id}")
            else:
                print(f"Message {message} could not be committed to leader {self.node_id}")
        else:
            if self.uncommitted_msg == message:
                self.message = message
            else:
                self.uncommitted_msg = message


        return True

    def send_heartbeat(self):
        #print(f"Heart Beat sent by {self.node_id}")
        self.voted = False
        for uri_n in peers:
            if uri_n["node_id"] != self.node_id:
                node_n = Pyro5.api.Proxy(f"PYRO:{uri_n['node_id']}@localhost:{uri_n['port']}")
                node_n.handle_heartbeat(self.current_term)
        self.start_heartbeat_timer()

    @Pyro5.api.expose
    def handle_heartbeat(self, leader_term):
        self.voted = False
        if leader_term > self.current_term:
            self.current_term = leader_term
            self.state = "follower"
            self.voted = False

        self.start_election_timer()

        return self.current_term

def main():
    time.sleep(5)
    index = int(sys.argv[1])
    port = peers[index]["port"]
    node_id = peers[index]["node_id"]
    daemon = Pyro5.api.Daemon(port=port)
    node = RaftNode(node_id, port)
    daemon.register(node, node_id)
    node.start_election_timer()
    daemon.requestLoop()


if __name__ == "__main__":
    main()
