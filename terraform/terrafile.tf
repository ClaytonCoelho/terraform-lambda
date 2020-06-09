resource "aws_dynamodb_table" "dynamodb-table" {
    name           = var.table_name
    hash_key       = "id"

    attribute {
        name = "id"
        type = "S"
    }

    attribute {
        name = "aircraft_prefix"
        type = "S"
    }

    attribute {
        name = "pilot_name"
        type = "S"
    }

    attribute {
        name = "max_load"
        type = "S"
    }

    attribute {
        name = "route"
        type = "S"
    }

resource "aws_iam_role" "iam_role_for_lambda" {
    name = "AWSRoleLambdaDynamoDBTable-${var.table_name}"
    description = "Role that allows reading and writing from AWS Lambda to the AWS DynamoDB table ${var.table_name}."


    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadWriteTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWriteItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/${var.table_name}"
        },
        {
            "Sid": "GetStreamRecords",
            "Effect": "Allow",
            "Action": "dynamodb:GetRecords",
            "Resource": "arn:aws:dynamodb:*:*:table/${var.table_name}/stream/* "
        },
        {
            "Sid": "WriteLogStreamsAndGroups",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CreateLogGroup",
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "*"
        }
    ]
}
EOF
}


