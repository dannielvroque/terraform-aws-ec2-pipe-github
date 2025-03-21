terraform {
  backend "s3" {
    bucket = "s3-tfsate-danniel-unique123"
    key    = "terraform.tfstate"
    region = "us-east-1"  # A região pode ser qualquer uma
    encrypt = true
  }
}