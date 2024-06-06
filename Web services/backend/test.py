import requests

base_url = 'http://127.0.0.1:5000/api'

# Test GET /restaurants
response = requests.get(f'{base_url}/restaurants')
print('GET /restaurants:', response.json())

# Test POST /restaurants
new_restaurant = {
    'nome': 'Burger King',
    'tipoComida': 'hamburguer',
    'valorEntrega': 3.5,
    'valorAvaliacao': 4.0
}
response = requests.post(f'{base_url}/restaurants', json=new_restaurant)
print('POST /restaurants:', response.json())

# Test GET /restaurants/1/menu
response = requests.get(f'{base_url}/restaurants/1/menu')
print('GET /restaurants/1/menu:', response.json())

# Test POST /restaurants/1/menu
new_menu_item = {
    'nome': 'Pepperoni Pizza',
    'descricao': 'Pepperoni, cheese, and tomato sauce',
    'preco': 12.99,
    'quantidade': 1
}
response = requests.post(f'{base_url}/restaurants/1/menu', json=new_menu_item)
print('POST /restaurants/1/menu:', response.json())

# Test POST /cart
cart_items = {
    'items': [{'id': 1, 'quantidade': 2}]
}
response = requests.post(f'{base_url}/cart', json=cart_items)
print('POST /cart:', response.json())

# Test GET /cart
response = requests.get(f'{base_url}/cart')
print('GET /cart:', response.json())

# Test POST /orders
new_order = {
    'cart_id': 1,
    'restaurant_id': 1
}
response = requests.post(f'{base_url}/orders', json=new_order)
print('POST /orders:', response.json())

# Test GET /orders/1
response = requests.get(f'{base_url}/orders/1')
print('GET /orders/1:', response.json())

# Test PUT /orders/1
update_order_status = {
    'status': 'a_caminho'
}
response = requests.put(f'{base_url}/orders/1', json=update_order_status)
print('PUT /orders/1:', response.json())
