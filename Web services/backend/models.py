from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Restaurant(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    tipo_comida = db.Column(db.Enum('hamburguer', 'pizza', 'doces', 'japonesa', name='tipo_comida_enum'), nullable=False)
    cardapio = db.relationship('MenuItem', backref='restaurant', lazy=True)
    valor_entrega = db.Column(db.Float, nullable=False)
    valor_avaliacao = db.Column(db.Float, nullable=False)

class MenuItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    descricao = db.Column(db.String(255), nullable=True)
    preco = db.Column(db.Float, nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)
    restaurant_id = db.Column(db.Integer, db.ForeignKey('restaurant.id', name='fk_menuitem_restaurant'), nullable=False)

class CartItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    menu_item_id = db.Column(db.Integer, db.ForeignKey('menu_item.id', name='fk_cartitem_menuitem'), nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)
    cart_id = db.Column(db.Integer, db.ForeignKey('cart.id', name='fk_cartitem_cart'), nullable=False)
    menu_item = db.relationship('MenuItem')

class Cart(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    cart_items = db.relationship('CartItem', backref='cart', lazy=True)
    valor_entrega = db.Column(db.Float, nullable=False)
    preco_total = db.Column(db.Float, nullable=False)

class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    cart_id = db.Column(db.Integer, db.ForeignKey('cart.id', name='fk_order_cart'), nullable=False)
    cart = db.relationship('Cart')
    status = db.Column(db.Enum('enviado', 'em_progresso', 'a_caminho', 'entregue', name='status_entrega_enum'), nullable=False)
