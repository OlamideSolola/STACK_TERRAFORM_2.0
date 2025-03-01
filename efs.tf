#---------------------Creating an elastic file system ------------------
resource "aws_efs_file_system" "web-app-efs" {
  creation_token  = "web-app-efs"
  tags            = {
    Name          = "TF-EFS"
  }
}


#------------------Creating an efs mount target---------------
resource "aws_efs_mount_target" "efs-mount" {
  count = length(var.availability_zones)
  file_system_id  = aws_efs_file_system.web-app-efs.id
  subnet_id       = aws_subnet.Clixx-App-Private-Subnet[count.index].id
  security_groups = [aws_security_group.EFS-security-group.id]
}

