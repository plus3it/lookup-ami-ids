locals {
  name_filter = "amzn-ami-hvm-*"
  ami_filters = [
    {
      Name  = "description",
      Value = "Amazon Linux AMI*"
    },
    {
      Name  = "architecture",
      Value = "x86_64"
    },
    {
      Name  = "root-device-type",
      Value = "ebs"
    },
  ]
  owners = ["amazon"]
}

module "complex_search" {
  source = "../modules/cfn"

  Name = "ami-lookup-test-complex-search"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes     = 5
  AmiNameSearchString  = local.name_filter
  AdditionalAmiFilters = local.ami_filters
  AmiOwners            = local.owners
}

data "aws_ami" "tf_data_source" {
  most_recent = true
  name_regex  = local.name_filter
  owners      = local.owners

  dynamic "filter" {
    for_each = local.ami_filters
    content {
      name   = filter.value["Name"]
      values = [filter.value["Value"]]
    }
  }
}
