terraform {
  backend "s3" {
    bucket = "s3-tfsate-danniel-unique123"  # Nome exclusivo do bucket
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}