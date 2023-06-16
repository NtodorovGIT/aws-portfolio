terraform {
  backend "s3" {
    bucket = "state-file-bucket-ntjgf"
    key    = "state_bucket/terraform.tfstate"
    region = "eu-south-1"
  }
}