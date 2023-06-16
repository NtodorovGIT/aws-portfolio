resource "aws_launch_template" "launch_template" {
  instance_type = "t3.micro"
  image_id      = "ami-03a68febd9b9a5403"
  name          = "Web_instance"
  key_name      = "ec2-ssh-key"
  depends_on    = [aws_nat_gateway.public_nat_gw, aws_iam_role.web_role]
  tags = {
    name = "Web_instance"
  }
  network_interfaces {
    subnet_id       = aws_subnet.private_subnet.id
    security_groups = [aws_security_group.sg_private.id]
  }
  iam_instance_profile {
    arn = aws_iam_instance_profile.web_instance_profile.arn
  }
  user_data = base64encode(data.template_file.instance_application.rendered)
}

resource "aws_autoscaling_group" "web_autoscaling" {
  name                      = "web_autoscaling"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = [aws_subnet.private_subnet.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = "true"
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
  target_group_arns = [aws_lb_target_group.tg.arn]
}

resource "aws_autoscaling_policy" "as_policy" {
  autoscaling_group_name = aws_autoscaling_group.web_autoscaling.id
  name                   = "web_as_policy"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_autoscaling.id
  lb_target_group_arn    = aws_lb_target_group.tg.id
}