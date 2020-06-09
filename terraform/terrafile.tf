module "dynamodb_table" {
  source = "./dynamodb"

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


