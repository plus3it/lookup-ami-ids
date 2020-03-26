output "cfn_ami_id" {
  value       = module.failure.ami_id
  description = "The AMI id returned via cloudformation"
}
