#---------- Data Source for AMI ---------
data "aws_ami" "stack_ami" {
  owners      = ["self"]
  name_regex  = "^ami-stack-1.*"
  most_recent = true
  filter {
    name      = "name"
    values    = ["ami-stack-*"]
  }
}

#------------ Data source for subnet ----------
data "aws_subnets" "stack_sub" {
  filter {
    name      = "vpc-id"
    values    = [aws_vpc.main.id]
  }
}




  #-------------Data source of Snapshot-----------------------------------
data "aws_db_snapshot" "my_clixx_snapshot" {
  db_instance_identifier = "wordpressdbclixx"
  most_recent = true
  }

  #--------------Data Source to get the domaine name----------------------
data "aws_route53_zone" "domain_name" {
  name = "stack-olamide-solola.com"
}

#---------------Data source for secrets manager--------------------
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "creds"
}

