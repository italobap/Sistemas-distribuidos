import pika
import threading

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

channel.queue_declare(queue='order_queue')
channel.queue_declare(queue='delivery_queue')

def publish_order(order):
    channel.basic_publish(exchange='', routing_key='order_queue', body=order)
    print("Order published:", order)

def delivery_listener():
    def callback(ch, method, properties, body):
        print("Delivery received:", body.decode())

    channel.basic_consume(queue='delivery_queue', on_message_callback=callback, auto_ack=True)
    print("Waiting for deliveries...")
    channel.start_consuming()

def main():
    delivery_thread = threading.Thread(target=delivery_listener)
    delivery_thread.start()

    while True:
        action = input("Enter '1' to place an order, or 'q' to quit: ")
        if action == '1':
            order = input("Enter your order: ")
            publish_order(order)
        elif action.lower() == 'q':
            break
        else:
            print("Invalid input. Please try again.")

    print("Exiting...")
    connection.close()

if __name__ == '__main__':
    main()
