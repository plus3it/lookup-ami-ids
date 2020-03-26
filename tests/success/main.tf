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

module "success" {
  source = "../modules/cfn"

  Name = "ami-lookup-test-complex-search"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes = 5
  AmiFilters       = local.ami_filters
  AmiOwners        = local.owners
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
