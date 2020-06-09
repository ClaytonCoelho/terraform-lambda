import boto3

def lambda_handler(event: dict, context: dict) -> dict:
    """   Lambda function to get information about all items in a table 
        in AWS DynamoDB.
          The function receives table name via dictionary in 
        the "event" argument.
          Returns dictionary with the key "status_code" containing 200 
        as success and "msg" containing the list with data from all items.

    Args:
        event (dict): Dictionary with the keys "table_name".
        context (dict): Dictionary with the lambda function metadata.

    Returns:
        dict: Dictionary with the key "status_code" containing 200 
              as success and "msg" containing the list with data from items.
    """


    table_name = event['table_name'] # Table Name

    dynamodb = boto3.resource('dynamodb') # Create Resource Object
    table = dynamodb.Table(table_name) # Create Table Object

    # Get all items data
    response = table.scan()
    
    # Return dict with "status_code" and "msg"
    return {
        'status_code': 200,
        'msg': response["Items"]
    }