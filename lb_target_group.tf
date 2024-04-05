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

# resource "aws_lb_target_group_attachment" "WebApp-Attachment" {
#   target_group_arn      = aws_lb_target_group.WebAppTFTG.arn
#   count                 = var.stack_controls["ec2_create"] == "Y" ? 2 : 0
#   target_id             = element(aws_autoscaling_group.WebApp-ASG.*.id, count.index)
#   port = 80
# }