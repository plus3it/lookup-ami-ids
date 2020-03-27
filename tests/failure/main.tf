locals {
  ami_filters = [
    {
      Name   = "name",
      Values = ["amzn-ami-hvm-*"]
    }
  ]
  owners = ["foo"]
}

module "failure" {
  source = "../modules/cfn"

  Name = "ami-lookup-failure-test"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes = 5
  AmiFilters       = local.ami_filters
  AmiOwners        = local.owners
}
