import requests
from flask import Blueprint, request, jsonify

from flaskbackend.app import server_side_event
from models import db, Restaurant, MenuItem, Cart, CartItem, Order
from flask_sse import sse
bp = Blueprint('api', __name__)
    

# Restaurant routes
@bp.route('/restaurants', methods=['GET'])
def get_restaurants():
    restaurants = Restaurant.query.all()
    return jsonify([{
        'id': r.id,
        'nome': r.nome,
        'tipoComida': r.tipo_comida,
        'valorEntrega': r.valor_entrega,
        'valorAvaliacao': r.valor_avaliacao
    } for r in restaurants]), 200

@bp.route('/restaurants', methods=['POST'])
def create_restaurant():
    data = request.get_json()
    new_restaurant = Restaurant(
        nome=data['nome'],
        tipo_comida=data['tipoComida'],
        valor_entrega=data['valorEntrega'],
        valor_avaliacao=data['valorAvaliacao']
    )
    db.session.add(new_restaurant)
    db.session.commit()
    return jsonify({'id': new_restaurant.id}), 201

@bp.route('/restaurants/<int:id>', methods=['GET'])
def get_restaurant(id):
    restaurant = Restaurant.query.get_or_404(id)
    return jsonify({
        'id': restaurant.id,
        'nome': restaurant.nome,
        'tipoComida': restaurant.tipo_comida,
        'valorEntrega': restaurant.valor_entrega,
        'valorAvaliacao': restaurant.valor_avaliacao
    }), 200

@bp.route('/restaurants/<int:id>', methods=['PUT'])
def update_restaurant(id):
    data = request.get_json()
    restaurant = Restaurant.query.get_or_404(id)
    restaurant.nome = data.get('nome', restaurant.nome)
    restaurant.tipo_comida = data.get('tipoComida', restaurant.tipo_comida)
    restaurant.valor_entrega = data.get('valorEntrega', restaurant.valor_entrega)
    restaurant.valor_avaliacao = data.get('valorAvaliacao', restaurant.valor_avaliacao)
    db.session.commit()
    return jsonify({'id': restaurant.id}), 200

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
        'id': item.id,
        'nome': item.nome,
        'descricao': item.descricao,
        'preco': item.preco,
        'quantidade': item.quantidade
    } for item in items]), 200

@bp.route('/restaurants/<int:id>/menu', methods=['POST'])
def add_menu_item(id):
    data = request.get_json()
    new_item = MenuItem(
        nome=data['nome'],
        descricao=data['descricao'],
        preco=data['preco'],
        quantidade=data['quantidade'],
        restaurant_id=id
    )
    db.session.add(new_item)
    db.session.commit()
    return jsonify({'id': new_item.id}), 201

@bp.route('/restaurants/<int:id>/menu/<int:item_id>', methods=['PUT'])
def update_menu_item(id, item_id):
    data = request.get_json()
    item = MenuItem.query.get_or_404(item_id)
    item.nome = data.get('nome', item.nome)
    item.descricao = data.get('descricao', item.descricao)
    item.preco = data.get('preco', item.preco)
    item.quantidade = data.get('quantidade', item.quantidade)
    db.session.commit()
    return jsonify({'id': item.id}), 200

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
        cart = Cart(valor_entrega=0, preco_total=0)
        db.session.add(cart)
        db.session.commit()
    for item in data['items']:
        menu_item = MenuItem.query.get_or_404(item['itemCardapio']['id'])
        cart_item = CartItem(menu_item_id=menu_item.id, quantidade=item['quantidade'], cart_id=cart.id)
        db.session.add(cart_item)
        cart.preco_total += menu_item.preco * item['quantidade'] + menu_item.preco
    db.session.commit()
    return jsonify({'cart_id': cart.id, 'preco_total': cart.preco_total}), 201

@bp.route('/cart', methods=['GET'])
def get_cart():
    cart = Cart.query.first()
    if not cart:
        return jsonify({'message': 'Cart is empty'}), 200
    items = [{'id': ci.menu_item.id, 'nome': ci.menu_item.nome, 'quantidade': ci.quantidade,
              'preco': ci.menu_item.preco, 'descricao': ci.menu_item.descricao}
             for ci in cart.cart_items]
    return jsonify({'items': items, 'preco_total': cart.preco_total, 'valor_entrega': cart.valor_entrega}), 200

# Order routes
@bp.route('/orders', methods=['POST'])
def place_order():
    data = request.get_json()
    cart = Cart.query.get_or_404(data['carrinho']['id'])
    order = Order(cart_id=cart.id, status='em_progresso')
    db.session.add(order)
    db.session.commit()
    return jsonify({'order_id': order.id, 'status': order.status}), 201

@bp.route('/orders/<int:id>', methods=['GET'])
def get_order(id):
    order = Order.query.get_or_404(id)
    cart = Cart.query.get_or_404(order.cart_id)
    items = [{'id': ci.menu_item.id, 'nome': ci.menu_item.nome, 'quantidade': ci.quantidade,
              'preco': ci.menu_item.preco, 'descricao': ci.menu_item.descricao}
             for ci in cart.cart_items]
    return jsonify({
        'id': order.id, 'cart': {
            'items': items, 'preco_total': cart.preco_total, 'valor_entrega': cart.valor_entrega
        }, 'status': order.status
    }), 200

@bp.route('/orders/<int:id>', methods=['PUT'])
def update_order_status(id):
    data = request.get_json()
    order = Order.query.get_or_404(id)
    order.status = data.get('status', order.status)
    db.session.commit()
    server_side_event()
    return jsonify({'order_id': order.id, 'status': order.status}), 200

@bp.route('/cart', methods=['DELETE'])
def delete_all_cart_items():
    try:
        num_deleted = CartItem.query.delete()
        db.session.commit()
        return jsonify({'message': f'Deleted {num_deleted} cart items'}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500

@bp.route('/orders', methods=['DELETE'])
def delete_all_orders():
    try:
        num_deleted_orders = Order.query.delete()
        num_deleted_cart_items = CartItem.query.delete()
        num_deleted_carts = Cart.query.delete()
        db.session.commit()
        return jsonify({'message': f'Deleted {num_deleted_orders} orders, {num_deleted_cart_items} cart items, and {num_deleted_carts} carts'}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 500
