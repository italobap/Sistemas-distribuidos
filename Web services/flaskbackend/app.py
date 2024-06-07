from flask import Flask, request, jsonify, Response
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_sse import sse
from models import db, Restaurant, MenuItem, Cart, CartItem, Order
from routes import bp as api_bp
import time

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///restaurant.db'
db.init_app(app)
CORS(app)
app.config["REDIS_URL"] = "redis://redis"
app.register_blueprint(sse, url_prefix='/events')
app.register_blueprint(api_bp, url_prefix='/api')

with app.app_context():
    db.create_all()