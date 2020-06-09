resource "aws_dynamodb_table" "dynamodb-table" {
    name           = var.table_name
    hash_key       = var.primary_key.name
    billing_mode   = var.billing_mode
    read_capacity  = var.capacity.read
    write_capacity = var.capacity.write

    attribute {
        name = var.primary_key.name
        type = var.primary_key.type
    }
}

