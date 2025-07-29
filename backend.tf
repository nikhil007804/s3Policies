terraform {
  backend "s3" {
    bucket = "terraform-state-pratyushaa-ebs-w-hy"
    key    = "s3policies/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
