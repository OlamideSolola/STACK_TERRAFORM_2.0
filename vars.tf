
variable "environment" {
  default = "dev"
}

variable "default_vpc_id" {
  default = "vpc-04a893eb7c0d6beeb"
}

variable "system" {
  default = "Retail Reporting"
}

variable "subsystem" {
  default = "CliXX"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "subnets_cidrs" {
  type = list(string)
  default = [
    "172.31.80.0/20"
  ]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_key.pub"
}

variable "OwnerEmail" {
  default = "olamide.solola@gmail.com"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-stack-1.0"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}



variable "stack_controls" {
  type = map(string)
  default = {
    ec2_create = "Y"
    rds_create = "N"
    wp_create  = "N"
  }
}

variable "EC2_Components" {
  type = map(string)
  default = {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = "true"
    instance_type         = "t2.micro"
  }
}

variable "MOUNT_POINT" {
  default = "/var/www/html"
}

variable "ASG_launch_Components" {
  type = map(string)
  default = {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = "true"
    instance_type         = "t2.micro"
  }
}

variable "ASG_Components" {
  type = map(string)
  default = {
    min_size           = 2
    max_size           = 3
    delete_on_termination = true
    encrypted             = "true"
    instance_type         = "t2.micro"
  }
}

variable "DB_EMAIL" {
  default = "olamide.solola@gmail.com"
}

variable "EBS-vol1" {
  default = "/dev/sdg"
}

variable "EBS-vol2" {
  default = "/dev/sdh"
}

variable "EBS-vol3" {
  default = "/dev/sdi"
}

variable "EBS-vol4" {
  default = "/dev/sdj"
}

variable "EBS-vol-backup" {
  default = "/dev/sdk"
}

variable "Clixx-Private-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.0.0/24", "10.0.1.0/24"
  ]
}

variable "Bastion-Public-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.2.0/23", "10.0.4.0/23"
  ]
}

variable "RDS-Private-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.8.0/22", "10.0.12.0/22"
  ]
}

variable "Oracle-Private-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.16.0/24", "10.0.17.0/24"
  ]
}

variable "java-Private-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.20.0/26", "10.0.21.0/26"
  ]
}

variable "Private-Subnet-CIDR" {
  type = list(string)
  default = [
    "10.0.18.0/26", "10.0.19.0/26"
  ]
}


variable "availability_zones" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}

variable "EBS_Configuration" {
  type = list(object({
    device_name = string
    volume_size = number
  }))
  default = [ 
    {
    device_name = "/dev/sdb"
    volume_size = 8
  },
  {
    device_name = "/dev/sdc"
    volume_size = 8
  },
  {
    device_name = "/dev/sdd"
    volume_size = 8
  },
  {
    device_name = "/dev/sde"
    volume_size = 8
  },
  {
    device_name = "/dev/sdf"
    volume_size = 8
  }
   ]
}