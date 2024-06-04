from flask import Blueprint, Response, jsonify
from time import sleep

sse_bp = Blueprint('sse', __name__)
clients = []

@sse_bp.route('/events')
def sse():
    def event_stream():
        while True:
            sleep(1)
            for client in clients:
                yield f'data: {client}\n\n'

    return Response(event_stream(), content_type='text/event-stream')

@sse_bp.route('/notify/<message>')
def notify(message):
    clients.append(message)
    return jsonify({'message': 'Notified'}), 200
