resource "aws_instance" "bastion_instance" {
  ami                    = "ami-03a68febd9b9a5403"
  instance_type          = "t3.micro"
  key_name               = "ec2-ssh-key"
  subnet_id              = module.network.subnet_id[1]
  vpc_security_group_ids = [module.network.security_group_id[0]]
  iam_instance_profile   = aws_iam_instance_profile.bastion_instance_profile.id
  tags = {
    Name = "Bastion_case_study_2"
  }
}

resource "aws_iam_role" "bastion_ssm_role" {
  name = "bastion_instance_ssm"
  assume_role_policy = templatefile("${path.module}/templates/instance_policy.tftpl", {}
  )
  tags = {
    tag-key = "bastion_ssm"
  }
}

resource "aws_iam_policy_attachment" "bastion_attachment" {
  name       = "bastion_attachment"
  roles       = [aws_iam_role.bastion_ssm_role.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "bastion_instance_profile"
  role = aws_iam_role.bastion_ssm_role.id
}