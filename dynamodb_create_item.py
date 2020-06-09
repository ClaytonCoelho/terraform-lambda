import boto3

def lambda_handler(event: dict, context: dict) -> dict:
    """   Lambda function to create an item in an AWS DynamoDB table.
          The function receives table name and item data via dictionary 
        in the "event" argument.
          Returns dictionary with the key "status_code" containing 200 
        as success and "msg" containing the metadata about the creation
        of the item.

    Args:
        event (dict): Dictionary with the keys "table_name" 
                      and "item_data".
        context (dict): Dictionary with the lambda function metadata.

    Returns:
        dict: Dictionary with the key "status_code" containing 200 
              as success and "msg" containing the metadata about the 
              creation of the item.
    """
    
    table_name = event['table_name'] # Table Name
    item_data = event['item_data'] # Dict with item data.
    
    dynamodb = boto3.resource('dynamodb') # Create Resource Object
    table = dynamodb.Table(table_name) # Create Table Object
    
    # Create item into DynamoDB table
    response = table.put_item(
        Item=item_data
        )
    
    # Return dict with "status_code" and "msg"
    return {
        'status_code': 200,
        'msg': response['ResponseMetadata']
    }