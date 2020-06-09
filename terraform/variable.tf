variable "table_name" {
  type        = string
  default     = "flights"
  description = "AWS DynamoDB table name"
  
}

variable "lambda_function" {
  type        = list(string)
  default     = ["dynamodb_create_item", "dynamodb_get_all_items", "dynamodb_get_item"]
  description = "List with lambda function files names"
  
}


