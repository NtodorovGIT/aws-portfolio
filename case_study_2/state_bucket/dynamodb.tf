resource "aws_dynamodb_table" "state_table" {
  name = "dynamodb_state_lock_table_nt"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}