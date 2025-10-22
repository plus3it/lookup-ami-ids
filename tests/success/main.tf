locals {
  ami_filters = [
    {
      Name = "name",
      Values = [
        "al2023-ami-*-kernel-6.1-x86_64", # Used by real AWS endpoint
        "amzn2-ami-hvm-*",                # Used by moto mocked AWS endpoint, see https://github.com/getmoto/moto/blob/master/moto/ec2/resources/amis.json
      ]
    },
    {
      Name = "description",
      Values = [
        "Amazon Linux 2023*",  # Used by real AWS endpoint
        "Amazon Linux 2 AMI*", # Used by moto mocked AWS endpoint
      ]
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

  TimeoutInMinutes        = 5
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
