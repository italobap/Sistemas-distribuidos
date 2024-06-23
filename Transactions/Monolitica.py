import uuid

class OrderProcessing:
    def __init__(self):
        self.coordinator = Coordinator()
    
    def place_order(self, order):
        transaction_id = self.coordinator.begin_transaction()
        try:
            self.coordinator.prepare(order)
            self.coordinator.commit()
        except Exception as e:
            self.coordinator.rollback()
            print(f"Transaction {transaction_id} failed: {e}")

class Coordinator:
    def __init__(self):
        self.participants = [InventoryService(), PaymentService(), ShippingService()]
        self.transaction_logs = {}
        
    # Inicia uma nova transação
    def begin_transaction(self):
        transaction_id = str(uuid.uuid4())
        print(f"Transaction {transaction_id} started")
        self.transaction_logs[transaction_id] = {"status": "started"}
        return transaction_id
    
    def prepare(self, order):
        for participant in self.participants:
            participant.prepare(order)
    
    def commit(self):
        for participant in self.participants:
            participant.commit()
        print("Transaction committed")
    
    def rollback(self):
        for participant in self.participants:
            participant.rollback()
        print("Transaction rolled back")

class InventoryService:
    ITEM_PRICES = {
        "item1": 10.0,
        "item2": 5.0,
        "item3": 2.0,
        "item4": 1.0
    }
    
    ITEM_STOCK = {
        "item1": 1,
        "item2": 1,  
        "item3": 1,  
        "item4": 1  
    }
    
    def __init__(self):
        self.reserved_items = {}

    def prepare(self, order):
        # Verifique o estoque e reserva os itens
        print(f"InventoryService: Preparing for order {order['id']}")
        reserved_items = []
        for item in order['items']:
            if not self.is_item_in_stock(item):
                self.release_inventory(reserved_items)
                raise Exception(f"Inventory check failed for {item}")
            reserved_items.append(item)
        self.reserve_items(reserved_items)

    def commit(self):
        print("InventoryService: Committing inventory reservation")
        self.reserved_items = {}

    def rollback(self):
        print("InventoryService: Rolling back inventory reservation")
        self.release_inventory(list(self.reserved_items.keys()))

    def check_inventory(self, order):
        for item in order['items']:
            if not self.is_item_in_stock(item):
                return False
        return True

    def is_item_in_stock(self, item):
        # Verifique se o item está em estoque
        return self.ITEM_STOCK.get(item, 0) > self.reserved_items.get(item, 0)

    def reserve_items(self, items):
        # Reserva os itens diminuindo o estoque
        for item in items:
            if item in self.reserved_items:
                self.reserved_items[item] += 1
            else:
                self.reserved_items[item] = 1
            self.ITEM_STOCK[item] -= 1

    def release_inventory(self, items):
        # Liberar os itens reservados
        for item in items:
            if item in self.reserved_items:
                self.ITEM_STOCK[item] += self.reserved_items[item]
                del self.reserved_items[item]

    def calculate_total(self, order):
        return sum(self.ITEM_PRICES[item] for item in order['items'])


class PaymentService:
    def prepare(self, order):
        # Análise do pagamento
        print(f"PaymentService: Preparing for order {order['id']}")
        inventory_service = InventoryService()
        total_amount = inventory_service.calculate_total(order)
        if total_amount != order['paid_amount']:
            raise Exception(f"Payment amount {order['paid_amount']} does not match order total {total_amount}")

    def commit(self):
        print("PaymentService: Committing payment reservation")

    def rollback(self):
        print("PaymentService: Rolling back payment reservation")


class ShippingService:
    SHIPPING_LOCATIONS = ["São Paulo", "Rio de Janeiro", "Curitiba"]

    def prepare(self, order):
        print(f"ShippingService: Preparing for order {order['id']}")
        if not self.prepare_shipping(order):
            raise Exception("Shipping preparation failed")

    def commit(self):
        print("ShippingService: Committing shipping preparation")

    def rollback(self):
        print("ShippingService: Rolling back shipping preparation")

    def prepare_shipping(self, order):
        if self.schedule_shipment(order['shipping_address']):
            return True
        return False

    def schedule_shipment(self, shipping_address):
        if shipping_address in self.SHIPPING_LOCATIONS:
            print(f"Shipment scheduled to: {shipping_address}")
            return True
        else:
            print(f"Shipping address not valid: {shipping_address}")
            return False

if __name__ == "__main__":
    order_processing = OrderProcessing()

    orders = [
        {   #Pedido correto
            "id": 123,
            "items": ["item1", "item2"],  
            "shipping_address": "São Paulo",
            "paid_amount": 15.0
        },
        {   #Item fora do inventário
            "id": 124,
            "items": ["item3", "item5"],  
            "shipping_address": "Rio de Janeiro",
            "paid_amount": 3.0
        },
        {   #Valor pago errado
            "id": 125,
            "items": ["item3", "item4"],
            "shipping_address": "Curitiba",
            "paid_amount": 1.0 
        },
        {   #Valor pago errado e destino errado
            "id": 126,
            "items": ["item3", "item4"],
            "shipping_address": "Salvador",
            "paid_amount": 1.0
        },
        {   #Destino errado
            "id": 127,
            "items": ["item3", "item4"],
            "shipping_address": "Salvador",
            "paid_amount": 3.0
        },
        {   #Item sem estoque
            "id": 128,
            "items": ["item2", "item3"],
            "shipping_address": "Curitiba",
            "paid_amount": 7.0
        },
        {   #Pedido com sucesso
            "id": 129,
            "items": ["item3", "item4"],
            "shipping_address": "Curitiba",
            "paid_amount": 3.0
        }
        
    ]

    for order in orders:
        order_processing.place_order(order)
