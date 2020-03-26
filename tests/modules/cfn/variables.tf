variable "Name" {
  type        = string
  description = "(Required) Name of CloudFormation Stack"
}

variable "Capabilities" {
  type        = list(string)
  description = "(Optional) A list of capabilities. Valid values: CAPABILITY_IAM or CAPABILITY_NAMED_IAM"
  default     = []
}

variable "DisableRollback" {
  type        = string
  description = "(Optional) Set to true to disable rollback of the stack if stack creation failed. Conflicts with OnFailure"
  default     = false
}

variable "IamRoleArn" {
  type        = string
  description = "(Optional) The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials"
  default     = null
}

variable "NotificationArns" {
  type        = list(string)
  description = "(Optional) A list of SNS topic ARNs to publish stack related events"
  default     = []
}

variable "OnFailureAction" {
  type        = string
  description = "(Optional) Action to be taken if stack creation fails. This must be one of: DO_NOTHING, ROLLBACK, or DELETE. Conflicts with DisableRollback"
  default     = "DO_NOTHING"
}

variable "PatchGroup" {
  type        = string
  description = "(Optional) Key value of the Patch Group tag. Controls whether to create a PatchGroup tag that can be leveraged via SSM to auto-update instances."
  default     = null
}

variable "PolicyBody" {
  type        = string
  description = "(Optional) String containing the stack policy body. Conflicts with PolicyUrl"
  default     = null
}

variable "PolicyUrl" {
  type        = string
  description = "(Optional) URL to a file containing the stack policy. Conflicts with PolicyBody"
  default     = null
}

variable "RootVolumeSize" {
  type        = string
  description = "(Optional) Root Volume Size in GB **NOTE** This value can be set larger than the default (20GB) but NOT smaller. If set larger than default value partition will need to be expanded manually."
  default     = "20"
}

variable "StackTags" {
  type        = map(string)
  description = "(Optional) A map of tag keys/values to associate with this stack"
  default     = {}
}

variable "TimeoutInMinutes" {
  type        = string
  description = "(Optional) The amount of time that can pass before the stack status becomes CREATE_FAILED"
  default     = "30"
}

variable "AmiId" {
  type        = string
  description = "(Optional) Id of the ami to use against "
  default     = ""
}

variable "AmiNameSearchString" {
  type        = string
  description = "search pattern to match against an AMI Name"
  default     = "Windows_Server-2016-English-Full-Base-*"
}

variable "AdditionalAmiFilters" {
  type = list(object(
    {
      Name  = string,
      Value = string
    }
  ))
  description = "List of maps with additional ami search filters"
  default = [
    {
      Name  = "",
      Value = ""
    }
  ]
}

variable "AmiOwners" {
  type        = list(string)
  description = "List of owners to filter ami search results against"
  default     = ["amazon"]
}
