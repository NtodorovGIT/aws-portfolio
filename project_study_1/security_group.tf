resource "aws_security_group" "sg_public" {
  name        = "public_sg_bastion"
  description = "allow_internet"
  vpc_id      = aws_vpc.server_vpc.id

  ingress {
    description = "internet_access"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "internet_access"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_private" {
  name        = "private_sg_web"
  description = "allow_ssh"
  vpc_id      = aws_vpc.server_vpc.id

  ingress {
    description     = "SSH_bastion"
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.sg_public.id]
  }

  ingress {
    description     = "HTTPS_Internet"
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.sg_public.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}