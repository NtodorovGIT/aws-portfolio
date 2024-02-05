## Summary 

This README is about deploying an application module.

This module installs Apache Web Server in an autoscaling group behind an application load balancer.

## Usage

The `module block` should look like this:

```hcl
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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_attachment.asg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.web_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.as_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_iam_instance_profile.web_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.web_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.bastion_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_launch_template.launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http_lis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nat_gw_vpc"></a> [nat\_gw\_vpc](#input\_nat\_gw\_vpc) | n/a | `string` | n/a | yes |
| <a name="input_private_sg_id"></a> [private\_sg\_id](#input\_private\_sg\_id) | n/a | `string` | n/a | yes |
| <a name="input_private_subnet_id"></a> [private\_subnet\_id](#input\_private\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_public_alb_subnet_id"></a> [public\_alb\_subnet\_id](#input\_public\_alb\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_public_sg_id"></a> [public\_sg\_id](#input\_public\_sg\_id) | n/a | `string` | n/a | yes |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->