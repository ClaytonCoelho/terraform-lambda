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

if __name__ == "__main__":
    d = DynamoDB('flights')
    item = {
        "id": "AA962",
        "aircraft_prefix": "N930NN",
        "pilot_name": "Deep, Jhon",
        "max_load": "136.9",
        "route": "GRU-DFW"
    }
    r = d.create_item(item)
    print(r)

