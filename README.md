# lookup-ami-ids

AWS Lambda based cloudformation custom resource to lookup AMI IDs by AMI Name.

See the tests directory of this project for examples on how to consume this resource.

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The function name of the lambda | `string` | `"cfn-lookup-ami-ids"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The log level of the lambda function | `string` | `"INFO"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | The name of the Lambda function |

<!-- END TFDOCS -->
