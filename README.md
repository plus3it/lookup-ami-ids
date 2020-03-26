# lookup-ami-ids

AWS Lambda based cloudformation custom resource to lookup AMI IDs by AMI Name.

See the tests directory of this project for examples on how to consume this resource.

<!-- BEGIN TFDOCS -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| log\_level | The log level of the lambda function | `string` | `"INFO"` | no |

## Outputs

| Name | Description |
|------|-------------|
| function\_name | The name of the Lambda function |

<!-- END TFDOCS -->
