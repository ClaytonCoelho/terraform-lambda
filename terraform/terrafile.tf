module "dynamodb_table" {
  source = "./modules/aws-dynamodb"

  table_name = "flights"
  primary_key = {
      name = "id"
      type = "S"
  }
  billing_mode = "PROVISIONED"
  capacity = {
      read  = 20
      write = 20
  }

}

module "iam_role" {
  source = "./modules/aws-iam"

  table_name = module.dynamodb_table.aws_dynamodb_table_name
  
}

module "lambda_function" {
  source = "./modules/aws-lambda"

  code_path = "./modules/aws-lambda/codes"
  lambda_function_name = ["dynamodb_create_item", "dynamodb_get_all_items", "dynamodb_get_item"]
  runtime_code = "python3.8"
  iam_role_arn = module.iam_role.aws_iam_role_arn

}

