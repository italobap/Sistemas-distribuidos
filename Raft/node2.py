import Pyro5.api


@Pyro5.api.expose
class Node2(object):

    def __init__(self):
        print('init 2')

    def teste(self, mensagem):
        print("Teste 2")


def main():
    node_2 = Node2()
    ns = Pyro5.api.locate_ns()
    print(ns.list())

    daemon = Pyro5.api.Daemon(port=8002)
    uri = daemon.register(node_2, 'node_teste2')
    ns.register('lider2', uri)
    print(ns.list())
    daemon.requestLoop()

main()
