locals {
  ServerPrefix = ""
}

locals {
  creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}




#-----------------Creating a Bastion Server ---------------------
resource "aws_instance" "Bastion-server" {
  count                   = length(var.availability_zones)
  ami                     = data.aws_ami.stack_ami.id
  instance_type           = var.EC2_Components["instance_type"]
  vpc_security_group_ids  = [aws_security_group.Bastion-sg.id]
  key_name                = aws_key_pair.Stack_KP.key_name
  subnet_id               = aws_subnet.Bastion-Public-Subnet[count.index].id
  associate_public_ip_address = true
 root_block_device {
    volume_type           = var.EC2_Components["volume_type"]
    volume_size           = var.EC2_Components["volume_size"]
    delete_on_termination = var.EC2_Components["delete_on_termination"]
    encrypted = var.EC2_Components["encrypted"] 
  }
  tags = {
   Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "Bastion_Server_"}${count.index}"
   Environment = var.environment
   OwnerEmail = var.OwnerEmail
}
}

#--------------------Creating the RDS Snapshot------------------------------
resource "aws_db_instance" "Clixx_database_instance" {
  count = length(var.availability_zones)
  identifier = "wordpressdbclixx-${count.index}"
  instance_class = "db.m6gd.large"
  username = local.creds.DB_USER
  password = local.creds.DB_PASSWORD
  snapshot_identifier = data.aws_db_snapshot.my_clixx_snapshot.id
  db_subnet_group_name = aws_db_subnet_group.Clixx_db_subnet_group2.name
  vpc_security_group_ids = [aws_security_group.DB-sg.id]
  skip_final_snapshot = true

  tags = {
    Name = "wordpressdbclixx-${count.index}"
  }
}

#-----------------Creating a subnet group-------------------------------
resource "aws_db_subnet_group" "Clixx_db_subnet_group2" {
  name = "clixx_db_subnet_group2"
  subnet_ids = aws_subnet.RDS-DB-Private-Subnet[*].id
}