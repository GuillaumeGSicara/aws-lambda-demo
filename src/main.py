def lambda_handler(event, context):
    payload = event.get('payload', '')

    # TODO: implement your logic here
    print(f"Hello from Lambda! Payload: {payload}")