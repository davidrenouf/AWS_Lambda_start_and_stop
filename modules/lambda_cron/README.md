## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cloudwatch_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.lambda_function_archive_file](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.assume_role_lambda_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_event_target_input"></a> [cloudwatch\_event\_target\_input](#input\_cloudwatch\_event\_target\_input) | n/a | `map(string)` | `{}` | no |
| <a name="input_cloudwatch_log_group_kms_key_arn"></a> [cloudwatch\_log\_group\_kms\_key\_arn](#input\_cloudwatch\_log\_group\_kms\_key\_arn) | n/a | `string` | n/a | yes |
| <a name="input_cloudwatch_rule_schedule_expression"></a> [cloudwatch\_rule\_schedule\_expression](#input\_cloudwatch\_rule\_schedule\_expression) | Must be like: cron(Minutes Hours Day-of-month Month Day-of-week Year) | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment name to which the bucket will be linked | `string` | n/a | yes |
| <a name="input_is_cloudwatch_rule_enabled"></a> [is\_cloudwatch\_rule\_enabled](#input\_is\_cloudwatch\_rule\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_lambda_archive_path"></a> [lambda\_archive\_path](#input\_lambda\_archive\_path) | Lambda generated ZIP archive path | `string` | n/a | yes |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | n/a | `string` | n/a | yes |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `string` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Handler function name | `string` | n/a | yes |
| <a name="input_lambda_iam_actions"></a> [lambda\_iam\_actions](#input\_lambda\_iam\_actions) | n/a | `list(string)` | `[]` | no |
| <a name="input_lambda_iam_policy_description"></a> [lambda\_iam\_policy\_description](#input\_lambda\_iam\_policy\_description) | n/a | `string` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | n/a | `string` | `"python3.8"` | no |
| <a name="input_lambda_source_file"></a> [lambda\_source\_file](#input\_lambda\_source\_file) | n/a | `string` | n/a | yes |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | n/a | `number` | `180` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to create the bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#output\_lambda\_iam\_role\_arn) | n/a |
