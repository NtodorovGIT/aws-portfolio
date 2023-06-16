resource "aws_iam_role" "web_role" {
  name = "web_instance_s3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "Web_s3_policy"
  }
}

resource "aws_iam_policy" "web_role_policy" {
  name        = "web_policy"
  path        = "/"
  description = "Provides s3 access for web instance"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_attachment" {
  name       = "web_attachment"
  roles      = [aws_iam_role.web_role.id]
  policy_arn = aws_iam_policy.web_role_policy.arn
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "web_instance_profile"
  role = aws_iam_role.web_role.id
}

resource "aws_iam_role" "bastion_role" {
  name = "bastion_instance_ssm"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "bastion_ssm"
  }
}

resource "aws_iam_policy_attachment" "bastion_attachment" {
  name       = "bastion_attachment"
  roles       =  [aws_iam_role.bastion_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "bastion_instance_profile"
  role = aws_iam_role.bastion_role.id
}
