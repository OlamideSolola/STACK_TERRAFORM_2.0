#---------------- Creating inbound security rule for the database ----------------
resource "aws_security_group_rule" "Bastion-DB-inbound" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from the Bastion server for HTTP requests"
    type                     ="ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}

resource "aws_security_group_rule" "WebAPP-DB-inbound" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from the Bastion server for HTTP requests"
    type                     ="ingress"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}


resource "aws_security_group_rule" "Bastion-DB-inbound_SSH" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic for Web from the Bastion server"
    type                     ="ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}

resource "aws_security_group_rule" "WebAPP-DB-inbound_SSH" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic for SSH from the Web server"
    type                     ="ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}

resource "aws_security_group_rule" "Bastion-DB-inbound_HTTPS" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from the public subnet"
    type                     ="ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}

resource "aws_security_group_rule" "WebApp-DB-inbound_HTTPS" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic fr"
    type                     ="ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}

resource "aws_security_group_rule" "Bastion-DB-inbound_MSQL" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from MSQL"
    type                     ="ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}

resource "aws_security_group_rule" "WebApp-DB-inbound_MSQL" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from MSQL"
    type                     ="ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}

resource "aws_security_group_rule" "Bastion-DB-inbound_Oracle" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from Oracle"
    type                     ="ingress"
    from_port                = 1521
    to_port                  = 1521
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}

resource "aws_security_group_rule" "WebAPP-DB-inbound_Oracle" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from Oracle"
    type                     ="ingress"
    from_port                = 1521
    to_port                  = 1521
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}

resource "aws_security_group_rule" "WebApp-DB-inbound_icmp" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from icmp"
    type                     ="ingress"
    from_port                = -1
    to_port                  = -1
    protocol                 = "icmp"
    source_security_group_id = aws_security_group.stack-webapp-sg.id
}

resource "aws_security_group_rule" "Bastion-DB-inbound_icmp" {
    security_group_id        = aws_security_group.DB-sg.id
    description              = "Allows inbound traffic from icmp"
    type                     ="ingress"
    from_port                = -1
    to_port                  = -1
    protocol                 = "icmp"
    source_security_group_id = aws_security_group.Bastion-sg.id
}



#--------------Creating outbound security rule for the database ---------------------
resource "aws_security_group_rule" "WebAPP-RDS-outbound" {
  security_group_id          = aws_security_group.DB-sg.id
  description                = "Allows all outbound traffic"
  type                       = "egress"
  from_port                  = 0
  to_port                    = 0
  protocol                   = "-1"
  source_security_group_id   = aws_security_group.stack-webapp-sg.id

}

resource "aws_security_group_rule" "Bastion-RDS-outbound" {
  security_group_id          = aws_security_group.DB-sg.id
  description                = "Allows all outbound traffic"
  type                       = "egress"
  from_port                  = 0
  to_port                    = 0
  protocol                   = "-1"
  source_security_group_id   = aws_security_group.Bastion-sg.id

}