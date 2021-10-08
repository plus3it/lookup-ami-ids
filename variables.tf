variable "function_name" {
  type        = string
  default     = "cfn-lookup-ami-ids"
  description = "The function name of the lambda"
}

variable "log_level" {
  type        = string
  default     = "INFO"
  description = "The log level of the lambda function"
}
