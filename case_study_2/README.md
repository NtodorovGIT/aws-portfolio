# Improving Apache Web Service Infrastructure Code

The second project is to improve the infrastructure code of the Apache Web Service by using modules concept, build-in function, locals, and expression.

For this purpose, the infrastructure is divided into two modules [application]() and [network]() to become more reusable.

This infrastructure supports the same functionality as the first project, but in addition is added a DynamoDB table for locking the `state.tf` file.

# Usage

Module invocation with both `module blocks`

``` hcl
module "network" {
  source = "./modules/network"
}

module "application" {
  source               = "./modules/application"
  vpc_id               = module.network.vpc_id
  nat_gw_vpc           = module.network.nat_gw_vpc
  private_sg_id        = module.network.security_group_id[1]
  public_sg_id         = module.network.security_group_id[0]
  private_subnet_id    = module.network.subnet_id[0]
  public_subnet_id     = module.network.subnet_id[1]
  public_alb_subnet_id = module.network.subnet_id[0]
}
```
## Code improvements
*  Removing hard coded values 
*  Adding description for all variables

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | ./modules/application | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.bastion_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy_attachment.bastion_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.bastion_ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.bastion_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_sg_public_id"></a> [sg\_public\_id](#output\_sg\_public\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->