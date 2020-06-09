variable "code_path" {
  type        = string
  description = "Path of the codes."
  
}

variable "lambda_function_name" {
  type        = list(string)
  description = "List with lambda function files names"
  
}

variable "runtime_code" {
  type        = string
  description = "Language runtime"
  
}

variable "iam_role_arn" {
  type        = string
  description = "ARN from AWS IAM Role"
  
}

