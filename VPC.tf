#-------------Creating the VPC-------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Clixx-App-VPC-10subnets"
  }
}

#-------------Creating the private subnet for the Clixx Web App-----------
resource "aws_subnet" "Clixx-App-Private-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.Clixx-Private-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "Clixx-App-Private-Subnet ${count.index + 1}"
 }
}

#-------------Creating the public subnet for the Bastion Server-----------
resource "aws_subnet" "Bastion-Public-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.Bastion-Public-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "Bastion-Public-Subnet ${count.index + 1}"
 }
}

#-------------Creating the private subnet for the RDS Database-----------
resource "aws_subnet" "RDS-DB-Private-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.RDS-Private-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "RDS-DB-Private-Subnet ${count.index + 1}"
 }
}

#-------------Creating the private subnet for the Oracle Database-----------
resource "aws_subnet" "Oracle-DB-Private-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.Oracle-Private-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "Oracle-DB-Private-Subnet ${count.index + 1}"
 }
}

#-------------Creating the private subnet for the Java-----------
resource "aws_subnet" "Java-Private-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.java-Private-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "Java-Private-Subnet ${count.index + 1}"
 }
}

#-------------Creating the other private subnet-----------
resource "aws_subnet" "Private-Subnet" {
 count             = length(var.availability_zones)
 vpc_id            = aws_vpc.main.id
 cidr_block        = element(var.Private-Subnet-CIDR, count.index)
 availability_zone = element(var.availability_zones, count.index)
 
 tags = {
   Name = "Other-Private-Subnet ${count.index + 1}"
 }
}


#----------------------Creating Route53----------------------
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain_name.id
  name = "www.clixx-app"
  type = "CNAME"
  ttl = "300"
  records = [aws_lb.Clixx-App-lb.dns_name]
#   latency_routing_policy {
#     region = var.AWS_REGION
    
#   }
}

#---------------Creating internet gateway----------------
resource "aws_internet_gateway" "Clixx-gw" {
 vpc_id = aws_vpc.main.id
 
 tags = {
   Name = "Clixx_VPC_IGW"
 }
}

#-------------Creating Elastic IP------------------
resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  domain = "vpc"
  tags = {
    "Name" = "ClixxNATGatewayEIP"
  }
}

#-------------Creating a NAT Gateway-----------------
resource "aws_nat_gateway" "Clixx_nat_gw" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id = aws_subnet.Bastion-Public-Subnet[count.index].id
}

#-------------Creating a route table for the public subnets-----------
resource "aws_route_table" "Pub_sub_rt" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Clixx-gw.id
  }

tags = {
  "Name" = "Bastion_pub_rt ${count.index + 1} "
}
}

#-------------Creating a route table for the Clixx private subnets-----------
resource "aws_route_table" "clixx_priv_sub_rt" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)
  tags = {
    "Name" = "Clixx_priv_sub_rt ${count.index + 1}"
  }
}


#-------------Creating a route table for the Oracle DB private subnets-----------
resource "aws_route_table" "OracleDB_priv_sub_rt" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)
  tags = {
    "Name" = "OracleDB_priv_sub_rt ${count.index + 1}"
  }
}

#-------------Creating a route table for the Java private subnets-----------
resource "aws_route_table" "Java_priv_sub_rt" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)
  tags = {
    "Name" = "Java_priv_sub_rt ${count.index + 1}"
  }
}

#-------------Creating a route table for the other private subnets-----------
resource "aws_route_table" "Other_priv_sub_rt" {
  vpc_id = aws_vpc.main.id
  count = length(var.availability_zones)
  tags = {
    "Name" = "Other_priv_sub_rt ${count.index + 1}"
  }
}




#-----------Directing traffic from priv subnet to the NAT gateway--------
resource "aws_route" "priv_internet_access" {
  count = length(var.availability_zones)
  route_table_id = aws_route_table.clixx_priv_sub_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.Clixx_nat_gw[count.index].id
}

#----------------Associating route table ---------------------
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.availability_zones)
 subnet_id      = aws_subnet.Bastion-Public-Subnet[count.index].id
 route_table_id = aws_route_table.Pub_sub_rt[count.index].id
}

resource "aws_route_table_association" "private_subnet_asso" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.Clixx-App-Private-Subnet[count.index].id
  route_table_id = aws_route_table.clixx_priv_sub_rt[count.index].id
}


#----------------Creating s3 Endpoint ---------------------
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.${local.creds.AWS_REGION}.s3"
}