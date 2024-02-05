resource "aws_iam_role" "web_role" {
  name = "web_instance_role"
  assume_role_policy = templatefile("${path.module}/templates/instance_policy.tftpl", {}
  )
  tags = {
    tag-key = "Web_role"
  }
}

resource "aws_iam_role_policy" "bastion_role_policy" {
  policy = templatefile("${path.module}/templates/iam_web_policy.tftpl", {})
  role   = aws_iam_role.web_role.id
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "web_instance_profile"
  role = aws_iam_role.web_role.id
}