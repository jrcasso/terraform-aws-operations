Terraform conforming to the operation zone specification [draft](https://github.com/jrcasso/mean-demo/issues/50#issuecomment-706654629).


## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Operation name; prototypical scopes include dev, stage, and production 'environments'. | `string` | n/a | yes |
| parent\_zone | VPC subnet CIDR for the operation | <pre>object({<br>    name = string<br>    id   = string<br>  })</pre> | n/a | yes |
| profile | AWS profile | `string` | `"personal"` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |
| vpc\_cidr | VPC subnet CIDR for the operation | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| hosted\_zone | n/a |
| sg\_ids | n/a |
| vpc\_cidr\_block | n/a |
| vpc\_id | n/a |
