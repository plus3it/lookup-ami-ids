output "ami_id" {
  value       = lookup(aws_cloudformation_stack.cfn.outputs, "AmiId", null)
  description = "The AMI id found via the cfn-look-up-ami-ids lambda"
}
