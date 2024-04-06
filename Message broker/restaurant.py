
import pika
import order

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.queue_declare(queue='order_queue')
channel.queue_declare(queue='delivery_queue')
channel.queue_declare(queue='retrieve_queue')


def deliver_order(order):
    print("Order delivered:", order)
    channel.basic_publish(exchange='', routing_key='delivery_queue', body=order)
    print("Delivery published:", order)


def notify_order(order):
    print("Order finished:", order)
    channel.basic_publish(exchange='', routing_key='retrieve_queue', body=order)
    print("Retrieval notification published:", order)


def classify_order(order):
    if order.orderType.lower() == 'd':
        deliver_order(str(order))
    elif order.orderType.lower() == 'p':
        notify_order(str(order))
    else:
        print("Invalid order type:", order.order_type)


def callback(ch, method, properties, body):
    print("Received order:", body.decode())
    received_order = order.Order.from_string(body.decode())
    classify_order(received_order)


channel.basic_consume(queue='order_queue', on_message_callback=callback, auto_ack=True)

print('Waiting for orders...')
channel.start_consuming()
