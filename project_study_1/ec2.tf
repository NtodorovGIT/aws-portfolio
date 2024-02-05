resource "aws_instance" "bastion_instance" {
  ami                    = "ami-03a68febd9b9a5403"
  instance_type          = "t3.micro"
  key_name               = "ec2-ssh-key"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_public.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_instance_profile.id

  tags = {
    Name = "Bastion_case_study_1"

  }
}