terraform {
  backend "s3" {
    bucket = "state-file-bucket-ntjgf"
    key    = "case_study_2/terraform.tfstate"
    region = "eu-south-1"
    dynamodb_table = "dynamodb_state_lock_table_nt"
  }
}