#---------------- Creating inbound security rule for EFS ----------------
resource "aws_security_group_rule" "efs-inbound" {
    security_group_id        =aws_security_group.EFS-security-group.id
    description              = "Allows inbound traffic for efs"
    type                     ="ingress"
    from_port                = 2049
    to_port                  = 2049
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}


#--------------Creating outbound security rule for EFS ---------------------
resource "aws_security_group_rule" "efs-outbound" {
  security_group_id          = aws_security_group.EFS-security-group.id
  description                = "Allows outbound traffic from efs"
  type                       = "egress"
  protocol                   = "tcp"
  from_port                  = 2049
  to_port                    = 2049
  cidr_blocks              = ["0.0.0.0/0"]

}