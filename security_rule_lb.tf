# #---------------- Creating inbound security rule for load balancer listener ----------------
# resource "aws_security_group_rule" "hhtp-lb-inbound" {
#     security_group_id = aws_security_group.alb-sg.id
#     description       = "Allow inbound hhtp traffic to loadbalancer from anywhere"
#     type              = "ingress" 
#     from_port         = 80
#     to_port           = 80
#     protocol          = "tcp"
#     cidr_blocks       = ["0.0.0.0/0"]

# }


# #---------------- Creating outbound security rule for load balancer listener ----------------
# resource "aws_security_group_rule" "lb-outbound" {
#     security_group_id = aws_security_group.alb-sg.id
#     description       = "Allow outbound traffic to the private subnet"
#     type              = "egress" 
#     from_port         = 0
#     to_port           = 0
#     protocol          = -1
#     cidr_blocks = aws_subnet.Clixx-App-Private-Subnet[*].cidr_block

# }


#---------------- Creating inbound security rule for the Bastion Server ----------------
resource "aws_security_group_rule" "lb-HTTP-inbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow inbound hhtp traffic"
    type              = "ingress" 
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "lb-SSH-inbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow inbound SSH traffic"
    type              = "ingress" 
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "lb-HTTPS-inbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow inbound SSH traffic "
    type              = "ingress" 
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "lb-mysql-inbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow inbound SSH traffic "
    type              = "ingress" 
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "lb-icmp-inbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow inbound SSH traffic"
    type              = "ingress" 
    from_port         = -1
    to_port           = -1
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]

}





#---------------- Creating outbound security rule for the Bastion Server ----------------
resource "aws_security_group_rule" "lb-outbound" {
    security_group_id = aws_security_group.alb-sg.id
    description       = "Allow all outbound traffic"
    type              = "egress" 
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]

}

# resource "aws_security_group_rule" "http_to_asg" {
#   security_group_id = aws_security_group.Bastion-sg.id
#   description       = "Allow HTTP traffic from bastion to auto scaling group"
#   type              = "egress" 
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = aws_security_group.stack-webapp-sg.id
# }