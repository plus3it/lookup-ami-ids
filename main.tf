
data "aws_iam_policy_document" "lambda" {
  statement {
    sid       = "AllowReadSSMParam"
    actions   = ["ec2:DescribeImages"]
    resources = ["*"]
  }

}

module "lambda" {
  source = "github.com/claranet/terraform-aws-lambda"

  function_name = var.function_name
  description   = "Looks up AMI IDs for cloudformation"
  handler       = "lambda.handler"
  runtime       = "python3.7"
  timeout       = 300

  source_path = "${path.module}/lambda"

  policy = data.aws_iam_policy_document.lambda

  environment = {
    variables = {
      LOG_LEVEL = var.log_level
    }
  }
}
