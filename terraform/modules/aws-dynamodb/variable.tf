variable "table_name" {
  type        = string
  description = "AWS DynamoDB table name"
  
}

variable "primary_key" {
  type        = object({
      name = string
      type = string
  })
  description = "Primary Key table"
  
}

variable "billing_mode" {
  type        = string
  description = "AWS DynamoDB billing mode"
  
}

variable "capacity" {
  type        = object({
      read  = number
      write = number
  })
  description = "Capacity Read and Write"
  
}
