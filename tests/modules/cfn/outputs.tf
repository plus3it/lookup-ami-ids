output "ami_id" {
  value       = aws_cloudformation_stack.cfn.outputs.AmiId
  description = "The AMI id found via the cfn-look-up-ami-ids lambda"
}
