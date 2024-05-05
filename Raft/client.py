import Pyro5.api

class Client:
    

    def main(self):
        ns = Pyro5.api.locate_ns()
        print(ns.list())
        uri_lider = ns.lookup("leader")
        lider = Pyro5.client.Proxy(uri_lider)
        lider.append_entries(1)


client = Client()
client.main()
