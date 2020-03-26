output "cfn_ami_id" {
  value       = module.success.ami_id
  description = "The AMI id returned via cloudformation"
}

output "tf_data_source" {
  value       = data.aws_ami.tf_data_source.image_id
  description = "The AMI id returned via the terraform data source"
}
