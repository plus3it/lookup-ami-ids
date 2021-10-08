locals {
  ami_filters = [
    {
      Name   = "name",
      Values = ["amzn-ami-hvm-*"]
    },
    {
      Name   = "description",
      Values = ["Amazon Linux AMI*"]
    },
    {
      Name   = "architecture",
      Values = ["x86_64"]
    },
    {
      Name   = "root-device-type",
      Values = ["ebs"]
    },
  ]
  owners = ["amazon"]
}

resource "random_id" "aws-lookup-lambda" {
  byte_length = 1
  prefix      = "test-cfn-lookup-ami-ids-"
}

module "ami-lookup-lambda" {
  source        = "../../"
  function_name = random_id.aws-lookup-lambda.hex
}

module "success" {
  source = "../modules/cfn"

  Name = "ami-lookup-test-complex-search"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes        = 1
  AmiFilters              = local.ami_filters
  AmiOwners               = local.owners
  AmiIdLookupFunctionName = module.ami-lookup-lambda.function_name
}

data "aws_ami" "tf_data_source" {
  most_recent = true
  owners      = local.owners

  dynamic "filter" {
    for_each = local.ami_filters
    content {
      name   = filter.value["Name"]
      values = filter.value["Values"]
    }
  }
}
