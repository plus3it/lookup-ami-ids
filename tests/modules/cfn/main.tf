module "ami-lookup-lambda" {
  source        = "../../../"
  function_name = var.AmiIdLookupFunctionName
}

resource "aws_cloudformation_stack" "cfn" {
  template_body = file("${path.module}/ami-id-lookup.template.cfn.yaml")

  name               = var.Name
  capabilities       = var.Capabilities
  disable_rollback   = var.DisableRollback
  iam_role_arn       = var.IamRoleArn
  notification_arns  = var.NotificationArns
  on_failure         = var.OnFailureAction
  policy_body        = var.PolicyBody
  policy_url         = var.PolicyUrl
  tags               = var.StackTags
  timeout_in_minutes = var.TimeoutInMinutes

  parameters = {
    AmiId                   = var.AmiId
    AmiFilters              = jsonencode(var.AmiFilters)
    AmiOwners               = jsonencode(var.AmiOwners)
    AmiIdLookupFunctionName = var.AmiIdLookupFunctionName
  }

  timeouts {
    create = "${var.TimeoutInMinutes}m"
    delete = "${var.TimeoutInMinutes}m"
    update = "${var.TimeoutInMinutes}m"
  }

  depends_on = [
    module.ami-lookup-lambda,
  ]
}
