import Pyro5.api


@Pyro5.api.expose
class Node1(object):

    def __init__(self):
        print('init')

    def teste(self, mensagem):
        print("Teste")


def main():
    node_1 = Node1()
    ns = Pyro5.api.locate_ns()
    print(ns.list())
    daemon = Pyro5.api.Daemon(port=8001)
    uri = daemon.register(node_1, 'node_teste')
    ns.register('lider', uri)
    print(ns.list())
    uri_node = ns.lookup('node_teste2')
    uri_node.teste()
    daemon.requestLoop()

main()
