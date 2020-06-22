import os

def lambda_handler(event, context):
    print(f"Event Received - {event}")
    return "{} from Lambda!".format(os.environ['greeting'])
