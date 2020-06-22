# Define the output variable for the lambda function.
output "lamba_arn" {
  value = aws_lambda_function.greet_lambda.arn
}

output "lambda_name" {
  value = aws_lambda_function.greet_lambda.function_name
}
