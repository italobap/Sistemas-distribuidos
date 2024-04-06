import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.queue_declare(queue='order_queue')
channel.queue_declare(queue='delivery_queue')

def callback(ch, method, properties, body):
    print("Received order:", body.decode())
    deliver_order(body)

def deliver_order(order):
    print("Order delivered:", order)
    channel.basic_publish(exchange='', routing_key='delivery_queue', body=order)
    print("Delivery published:", order)

channel.basic_consume(queue='order_queue', on_message_callback=callback, auto_ack=True)

print('Waiting for orders...')
channel.start_consuming()
