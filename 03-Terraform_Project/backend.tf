terraform {
  backend "s3" {
    bucket = "terraform-state-lakshmana-ap-south-1"
    key    = "03-Terraform_Project/terraform.tfstate"
    region = "ap-south-1"
  }
}
