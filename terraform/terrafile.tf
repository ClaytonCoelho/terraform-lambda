resource "aws_dynamodb_table" "dynamodb-table" {
    name           = var.table_name
    hash_key       = "id"
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20

    attribute {
        name = "id"
        type = "S"
    }
}


resource "aws_iam_policy" "policy" {
  name        = "AWSPolicyLambdaDynamoDBTable-${var.table_name}"
  path        = "/"
  depends_on = [aws_dynamodb_table.dynamodb-table]

  policy = <<EOF
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

resource "aws_iam_role" "role" {
    name = "AWSRoleLambdaDynamoDBTable-${var.table_name}"
    description = "Role that allows reading and writing from AWS Lambda to the AWS DynamoDB table ${var.table_name}."
    depends_on = [aws_dynamodb_table.dynamodb-table]


    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role-policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
  depends_on = [aws_iam_role.role, aws_iam_policy.policy]
}

resource "aws_lambda_function" "lambda" {
    filename = "../dynamodb_create_item.py.zip"
    function_name = "dynamodb_create_item"
    role = aws_iam_role.role.arn
    handler = "dynamodb_create_item.lambda_handler"

    runtime = "python3.8"
  
}


