
class Order:
    def __init__(self, body, orderType):
        self.body = body
        self.orderType = orderType

    def __len__(self):
        return len(self.body)

    def __str__(self) -> str:
        return f'{self.body}:{self.orderType}'

    @classmethod
    def from_string(cls, orderString):
        body, orderType = orderString.split(':')
        return cls(body, orderType)
