data "template_file" "instance_application" {
  template = <<-EOF
  #!/bin/bash
   yum install -y httpd
   systemctl start httpd
   systemctl enable httpd
  aws s3 cp s3://petroff-mentoring-training-bucket/case-study-html/index.html --region eu-south-1  /var/www/html/index.html
  EOF
}