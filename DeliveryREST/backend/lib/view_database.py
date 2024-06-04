from models import db, Restaurant, MenuItem, Cart, Order
from app import app

with app.app_context():
    restaurants = Restaurant.query.all()
    for restaurant in restaurants:
        print(restaurant.id, restaurant.name, restaurant.type)

    menu_items = MenuItem.query.all()
    for item in menu_items:
        print(item.id, item.name, item.description, item.price, item.delivery_price, item.rating)

    carts = Cart.query.all()
    for cart in carts:
        print(cart.id, cart.total_price)
        for item in cart.menu_items:
            print(item.menu_item_id, item.quantity)

    orders = Order.query.all()
    for order in orders:
        print(order.id, order.restaurant_id, order.status, order.rating, order.cart_id)
