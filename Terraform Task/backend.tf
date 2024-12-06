terraform {
  backend "s3" {
    bucket         = "tf-task-5thsem-useast1-33445343"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
  }
}
