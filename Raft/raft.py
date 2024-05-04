import Pyro5.api
import threading
import random
import time

# Constants
ELECTION_TIMEOUT = (5, 10)  # Random election timeout range in seconds
HEARTBEAT_INTERVAL = 2      # Interval for leader to send heartbeat
MAJORITY = 3                # Majority required for log entry commit

node_uri = [{"node_id" : "node_1","port" : 8001 },
            {"node_id" : "node_2","port" : 8002 }, 
            {"node_id" : "node_3","port" : 8003 }, 
            {"node_id" : "node_4","port" : 8004 }]
# Raft Node

@Pyro5.api.expose
class RaftNode:
    def __init__(self, node_id):
        self.node_id = node_id
        self.state = "follower"
        self.current_term = 0
        self.voted_for = None
        self.log = []
        self.commit_index = 0
        self.last_applied = 0
        self.leader_id = None
        self.next_index = {}
        self.match_index = {}
        self.election_timer = None

    def start_election_timer(self):
        if self.election_timer is not None:
            self.election_timer.cancel()
        timeout = random.uniform(*ELECTION_TIMEOUT)
        self.election_timer = threading.Timer(timeout, self.start_election)
        self.election_timer.start()

    def start_election(self):
        self.state = "candidato"  
        self.current_term +=1
        for i in range(3):
            uri_n = node_uri[i]
            node_n = Pyro5.client.Proxy(uri_n["node_id"])
            num_votes += node_n.request_vote(self.current_term)

        if num_votes > MAJORITY:
            self.become_leader()
              
        
    def request_vote(self,term,node_id):
        if(self.current_term > term):
            self.current_term = term
            self.voted_for = node_id
            return 


    def append_entries(self):
        # Send log entries to other nodes
        pass

    def become_leader(self):
        # Change state to leader and start sending heartbeats
        # Altera estado para leader e atualiza o leader_id de todo mundo
        pass

    def handle_heartbeat(self):
        # Handle received heartbeat from leader
        pass

    def sayHi(self):
        print("Hi!")

def main():
    node = RaftNode(node_id=node_uri["node_id"])
    daemon = Pyro5.api.Daemon(port=node_uri["port"])
    daemon.register(node, node_uri["node_id"])
    daemon.requestLoop()

main()