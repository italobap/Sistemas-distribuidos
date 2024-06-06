from flask import Flask, request, jsonify, Response
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from models import db
from routes import bp as api_bp
import time

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///restaurant.db'
db.init_app(app)
CORS(app)

# Store clients for SSE
clients = []

@app.route('/events')
def events():
    def event_stream():
        while True:
            if len(clients) > 0:
                for client in clients:
                    yield f'data: {client}\n\n'
                clients.clear()
            time.sleep(1)
    return Response(event_stream(), content_type='text/event-stream')

@app.route('/notify', methods=['POST'])
def notify():
    data = request.get_json()
    clients.append(data['message'])
    return jsonify({'message': 'Notification sent'}), 200

app.register_blueprint(api_bp, url_prefix='/api')

with app.app_context():
    db.create_all()

