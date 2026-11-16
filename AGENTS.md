# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module deploys a Python Lambda function that works as a CloudFormation custom resource to look up an AMI ID. The caller passes the `Owners` and `Filters` as JSON strings in the custom resource properties; the function calls `ec2:DescribeImages` and returns the ID of the newest matching image as `Id`. The module inputs are `function_name` (default `cfn-lookup-ami-ids`) and `log_level` (default `INFO`), and its only output is `function_name`, which a CloudFormation template uses to build the `ServiceToken` ARN.

### Module-specific files

- `lambda/` — Source of the Lambda function, packaged by the `claranet/terraform-aws-lambda` module that `main.tf` calls; `lambda.py` holds the handler, `cfnresponse.py` sends the response to CloudFormation, `exceptions.py` defines the no-results error, and `requirements.txt` lists the runtime packages
- `lambda/test_events/` — Sample CloudFormation custom resource events (success and failure) for the handler
- `tests/modules/cfn/` — Test helper module that creates a CloudFormation stack from `ami-id-lookup.template.cfn.yaml`, which declares a `Custom::AmiIdLookup` resource that calls the Lambda function
- `Dockerfile` — Builds on the tardigrade-ci image and installs `lambda/requirements.txt` so the Lambda packages are available in the image. The tardigrade-ci `docker/run` target, which the shared lint workflow calls, builds this image when it is not already present

There are no Python unit tests. The `tests/success` and `tests/failure` scenarios exercise the Lambda function through the CloudFormation stack.
