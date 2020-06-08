import boto3

class DynamoDB:
    def __init__(self, table_name):
        self.dynamodb = boto3.resource('dynamodb')
        self.table = self.dynamodb.Table(table_name)
    
    def create_item(self, item):
        try:
            response = self.table.put_item(
                Item=item
            )

            return {
                "status": "OK",
                "msg": response['ResponseMetadata']
            }
        except Exception as e:
            return {
                "status": "ERROR",
                "msg": e
            }
    
    def get_item(self, **kwargs):
        try:
            response = self.table.get_item(Key=kwargs)
            return {
                "status": "OK",
                "item": response["Item"]
            }
        except Exception as e:
            return {
                "status": "ERROR",
                "msg": e
            }
    
    def get_all_items(self):
        try:
            response = self.table.scan()
            items = response['Items']
            return {
                "status": "OK",
                "items": items
            }
        except Exception as e:
            return {
                "status": "ERROR",
                "msg": e
            }


if __name__ == "__main__":
    d = DynamoDB('flights')
    i = d.get_all_items()
    print(i)

