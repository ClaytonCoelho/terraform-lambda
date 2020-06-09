data "archive_file" "zip_files" {
  type        = "zip"

  for_each = toset(var.lambda_function_name)
  source_file = "${var.code_path}/${each.value}.py"
  output_path = "${var.code_path}/${each.value}.py.zip"
}

resource "aws_lambda_function" "lambda" {
    for_each = toset(var.lambda_function_name)
    filename = "${var.code_path}/${each.value}.py.zip"
    function_name = each.value
    role = var.iam_role_arn
    handler = "${each.value}.lambda_handler"

    runtime = var.runtime_code
  
}