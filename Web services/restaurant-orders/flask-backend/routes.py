from flask import Blueprint, request, jsonify
from models import db, Restaurant, MenuItem, Cart, CartItem, Order

bp = Blueprint('api', __name__)

# Restaurant routes
@bp.route('/restaurants', methods=['GET'])
def get_restaurants():
    restaurants = Restaurant.query.all()
    return jsonify([{'id': r.id, 'name': r.name, 'type': r.type} for r in restaurants]), 200

@bp.route('/restaurants', methods=['POST'])
def create_restaurant():
    data = request.get_json()
    new_restaurant = Restaurant(name=data['name'], type=data['type'])
    db.session.add(new_restaurant)
    db.session.commit()
    return jsonify({'id': new_restaurant.id, 'name': new_restaurant.name, 'type': new_restaurant.type}), 201

@bp.route('/restaurants/<int:id>', methods=['GET'])
def get_restaurant(id):
    restaurant = Restaurant.query.get_or_404(id)
    return jsonify({'id': restaurant.id, 'name': restaurant.name, 'type': restaurant.type}), 200

@bp.route('/restaurants/<int:id>', methods=['PUT'])
def update_restaurant(id):
    data = request.get_json()
    restaurant = Restaurant.query.get_or_404(id)
    restaurant.name = data.get('name', restaurant.name)
    restaurant.type = data.get('type', restaurant.type)
    db.session.commit()
    return jsonify({'id': restaurant.id, 'name': restaurant.name, 'type': restaurant.type}), 200

@bp.route('/restaurants/<int:id>', methods=['DELETE'])
def delete_restaurant(id):
    restaurant = Restaurant.query.get_or_404(id)
    db.session.delete(restaurant)
    db.session.commit()
    return jsonify({'message': 'Restaurant deleted'}), 200

# MenuItem routes
@bp.route('/restaurants/<int:id>/menu', methods=['GET'])
def get_menu_items(id):
    items = MenuItem.query.filter_by(restaurant_id=id).all()
    return jsonify([{
        'id': item.id, 'name': item.name, 'description': item.description,
        'price': item.price, 'delivery_price': item.delivery_price, 'rating': item.rating
    } for item in items]), 200

@bp.route('/restaurants/<int:id>/menu', methods=['POST'])
def add_menu_item(id):
    data = request.get_json()
    restaurant = Restaurant.query.get_or_404(id)
    new_item = MenuItem(
        name=data['name'],
        description=data['description'],
        price=data['price'],
        delivery_price=data['delivery_price'],
        rating=data['rating'],
        restaurant_id=restaurant.id
    )
    db.session.add(new_item)
    db.session.commit()
    return jsonify({
        'id': new_item.id,
        'name': new_item.name,
        'description': new_item.description,
        'price': new_item.price,
        'delivery_price': new_item.delivery_price,
        'rating': new_item.rating
    }), 201

@bp.route('/restaurants/<int:id>/menu/<int:item_id>', methods=['PUT'])
def update_menu_item(id, item_id):
    data = request.get_json()
    item = MenuItem.query.get_or_404(item_id)
    item.name = data.get('name', item.name)
    item.description = data.get('description', item.description)
    item.price = data.get('price', item.price)
    item.delivery_price = data.get('delivery_price', item.delivery_price)
    item.rating = data.get('rating', item.rating)
    db.session.commit()
    return jsonify({
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'delivery_price': item.delivery_price,
        'rating': item.rating
    }), 200

@bp.route('/restaurants/<int:id>/menu/<int:item_id>', methods=['DELETE'])
def delete_menu_item(id, item_id):
    item = MenuItem.query.get_or_404(item_id)
    db.session.delete(item)
    db.session.commit()
    return jsonify({'message': 'Menu item deleted'}), 200

# Cart routes
@bp.route('/cart', methods=['POST'])
def add_to_cart():
    data = request.get_json()
    cart = Cart.query.first()  # Simplified: assuming a single cart for demonstration
    if not cart:
        cart = Cart(total_price=0)
        db.session.add(cart)
        db.session.commit()
    for item in data['items']:
        menu_item = MenuItem.query.get_or_404(item['id'])
        cart_item = CartItem(menu_item_id=menu_item.id, cart_id=cart.id, quantity=item['quantity'])
        db.session.add(cart_item)
        cart.total_price += menu_item.price * item['quantity'] + menu_item.delivery_price
    db.session.commit()
    return jsonify({'cart_id': cart.id, 'total_price': cart.total_price}), 201

@bp.route('/cart', methods=['GET'])
def get_cart():
    cart = Cart.query.first()
    if not cart:
        return jsonify({'message': 'Cart is empty'}), 200
    items = [{'id': ci.menu_item.id, 'name': ci.menu_item.name, 'quantity': ci.quantity,
              'price': ci.menu_item.price, 'delivery_price': ci.menu_item.delivery_price}
             for ci in cart.menu_items]
    return jsonify({'items': items, 'total_price': cart.total_price}), 200

# Order routes
@bp.route('/orders', methods=['POST'])
def place_order():
    data = request.get_json()
    cart = Cart.query.get_or_404(data['cart_id'])
    order = Order(restaurant_id=data['restaurant_id'], status='progress', cart_id=cart.id)
    db.session.add(order)
    db.session.commit()
    return jsonify({'order_id': order.id, 'status': order.status}), 201

@bp.route('/orders/<int:id>', methods=['GET'])
def get_order(id):
    order = Order.query.get_or_404(id)
    cart = Cart.query.get_or_404(order.cart_id)
    items = [{'id': ci.menu_item.id, 'name': ci.menu_item.name, 'quantity': ci.quantity,
              'price': ci.menu_item.price, 'delivery_price': ci.menu_item.delivery_price}
             for ci in cart.menu_items]
    return jsonify({
        'id': order.id, 'restaurant_id': order.restaurant_id, 'status': order.status, 'rating': order.rating,
        'items': items, 'total_price': cart.total_price
    }), 200

@bp.route('/orders/<int:id>', methods=['PUT'])
def update_order_status(id):
    data = request.get_json()
    order = Order.query.get_or_404(id)
    order.status = data.get('status', order.status)
    order.rating = data.get('rating', order.rating)
    db.session.commit()
    return jsonify({'order_id': order.id, 'status': order.status, 'rating': order.rating}), 200
