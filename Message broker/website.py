import pika
import threading
import order


def publish_order(order):
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    channel = connection.channel()
    channel.queue_declare(queue='order_queue')
    channel.basic_publish(exchange='', routing_key='order_queue', body=order)
    print("Order published:", order)


def delivery_listener():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    channel = connection.channel()
    channel.queue_declare(queue='delivery_queue')

    def delivery_callback(ch, method, properties, body):
        print("Delivery received:", body.decode())

    channel.basic_consume(queue='delivery_queue', on_message_callback=delivery_callback, auto_ack=True)
    print("\nWaiting for confirmation...")
    try:
        channel.start_consuming()
    except KeyboardInterrupt:
        channel.stop_consuming()
        connection.close()


def retrieval_listener():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    channel = connection.channel()
    channel.queue_declare(queue='retrieve_queue')

    def retrieval_callback(ch, method, properties, body):
        print("Order ready for retrieval:", body.decode())

    channel.basic_consume(queue='retrieve_queue', on_message_callback=retrieval_callback, auto_ack=True)
    print("\nWaiting for retrieval notifications...")
    try:
        channel.start_consuming()
    except KeyboardInterrupt:
        channel.stop_consuming()
        connection.close()


def main():
    delivery_thread = threading.Thread(target=delivery_listener)
    delivery_thread.start()

    retrieval_thread = threading.Thread(target=retrieval_listener)
    retrieval_thread.start()

    while True:
        action = input("Enter '1' to place order or 'q' to quit: ")
        if action.lower() == '1':
            order_type = input("Enter 'd' for delivery or 'p' to pick it up at the restaurant:")
            order_body = input("Enter your order: ")
            new_order = order.Order(order_body, order_type)
            publish_order(str(new_order))
        elif action.lower() == 'q':
            break
        else:
            print("Invalid input. Please try again.")

    print("Exiting...")
    delivery_thread.join()
    retrieval_thread.join()


if __name__ == '__main__':
    main()
