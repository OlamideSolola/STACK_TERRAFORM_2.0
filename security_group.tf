#-------------- Creating Security Group for Clixx Application ---------------
resource "aws_security_group" "stack-webapp-sg" {
  vpc_id      = aws_vpc.main.id
  name        = "Stack-TF-WebDMZ"
  description = "Stack IT Security Group For CliXX System"
}


#--------------- Creating security group for EFS -----------------
resource "aws_security_group" "EFS-security-group" {
  vpc_id      = aws_vpc.main.id
  name        = "TF-efs-sg"
  description = "security group for efs"
}


#--------------- Creating Security Group for load balancer listener ----------
resource "aws_security_group" "alb-sg" {
  name        = "Clixx_LB_SG"
  description = "Security Group for Load Balancer"
  vpc_id      = aws_vpc.main.id
}


#--------------- Creating Security Group for Bastion server ----------
resource "aws_security_group" "Bastion-sg" {
  name        = "Bastion_SG"
  description = "Security Group for the Bastion Server"
  vpc_id      = aws_vpc.main.id
}

#--------------- Creating Security Group for DB server ----------
resource "aws_security_group" "DB-sg" {
  name        = "Database_SG"
  description = "Security Group for the Databases"
  vpc_id      = aws_vpc.main.id
}