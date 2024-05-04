import Pyro5.api

class Client:
    

    def main(self):
        ns = Pyro5.api.locate_ns()
        uri_lider = ns.lookup("lider")
        lider = Pyro5.client.Proxy(uri_lider)
        lider.sayHi()


client =  Client()
client.main()