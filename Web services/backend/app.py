from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from models import db
from routes import bp as api_bp
from sse import sse_bp

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///restaurant.db'
db.init_app(app)
CORS(app)

app.register_blueprint(api_bp, url_prefix='/api')
app.register_blueprint(sse_bp, url_prefix='/sse')

with app.app_context():
    db.create_all()
