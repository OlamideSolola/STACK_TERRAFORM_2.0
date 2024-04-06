provider "aws" {
# region = local.creds.AWS_REGION
assume_role {
    role_arn    = "arn:aws:iam::637423181558:role/Engineer"
  }
}
