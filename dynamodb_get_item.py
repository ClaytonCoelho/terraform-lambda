import boto3

def lambda_handler(event: dict, context: dict) -> dict:
    """   Lambda function to get information about an item in a table 
        in AWS DynamoDB.
          The function receives table name and primary key via dictionary 
        in the "event" argument.
          Returns dictionary with the key "status_code" containing 200 
        as success and "msg" containing the data from item.

    Args:
        event (dict): Dictionary with the keys "table_name" 
                      and "primary_key".
        context (dict): Dictionary with the lambda function metadata.

    Returns:
        dict: Dictionary with the key "status_code" containing 200 
              as success and "msg" containing the data from item.
    """


    table_name = event['table_name'] # Table Name
    primary_key = event['primary_key'] # Dict with primary key.


    dynamodb = boto3.resource('dynamodb') # Create Resource Object
    table = dynamodb.Table(table_name) # Create Table Object

    # Get item data from primary key
    response = table.get_item(
        Key=primary_key
        )
    
    # Return dict with "status_code" and "msg"
    return {
        'status_code': 200,
        'msg': response["Item"]
    }