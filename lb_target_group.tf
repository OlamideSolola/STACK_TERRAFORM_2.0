#-------------- Creating a web App target group ---------------
resource "aws_lb_target_group" "WebAppTFTG" {
  name                  = "WebAppTFTG"
  port                  = 80
  protocol              = "HTTP"
  vpc_id                = aws_vpc.main.id

  health_check {
    path                = "/index.html"
    protocol            = "HTTP"
    #matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

