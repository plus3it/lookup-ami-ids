locals {
  name_filter = "Windows_Server-2016-English-Full-Base-*"
  owners      = ["foo"]
}

module "failure" {
  source = "../modules/cfn"

  Name = "ami-lookup-failure-test"

  Capabilities = [
    "CAPABILITY_AUTO_EXPAND"
  ]

  TimeoutInMinutes    = 5
  AmiNameSearchString = local.name_filter
  AmiOwners           = local.owners
}
