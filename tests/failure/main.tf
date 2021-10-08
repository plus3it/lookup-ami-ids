locals {
  ami_filters = [
    {
      Name   = "name",
      Values = ["amzn-ami-hvm-*"]
    }
  ]
  owners = ["foo"]
}

resource "random_id" "aws-lookup-lambda" {
  byte_length = 1
  prefix      = "test-cfn-lookup-ami-ids-"
}

module "ami-lookup-lambda" {
  source        = "../../"
  function_name = random_id.aws-lookup-lambda.hex
}

module "failure" {
  source = "../modules/cfn"

  Name = "ami-lookup-failure-test"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes        = 1
  AmiFilters              = local.ami_filters
  AmiOwners               = local.owners
  AmiIdLookupFunctionName = module.ami-lookup-lambda.function_name
}
