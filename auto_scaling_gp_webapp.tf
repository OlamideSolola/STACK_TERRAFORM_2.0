#------------------ Creating launch template for autoscaling group ---------------
resource "aws_launch_template" "WebApp-ASG-LC" {
  image_id                 = data.aws_ami.stack_ami.id
  instance_type            = var.ASG_launch_Components["instance_type"]
  vpc_security_group_ids   = [aws_security_group.stack-webapp-sg.id, aws_security_group.Bastion-sg.id]
  user_data                = "${base64encode(data.template_file.bootstrap_clixx.rendered)}"
  name                     = "Clixx-ASG-LC"
  dynamic "block_device_mappings" {
    for_each               = var.EBS_Configuration

    content {
      device_name          = block_device_mappings.value.device_name
      ebs {
        volume_size        = block_device_mappings.value.volume_size
      }
    }
  }

  lifecycle {create_before_destroy= true}

}

#-------------------- Creating autoscaling group ---------------------
resource "aws_autoscaling_group" "WebApp-ASG" {
  count                  = length(var.availability_zones)
  launch_template {
    id = aws_launch_template.WebApp-ASG-LC.id
  }
  vpc_zone_identifier    = aws_subnet.Clixx-App-Private-Subnet[*].id
 target_group_arns       = [aws_lb_target_group.WebAppTFTG.arn]
  health_check_type      = "EC2"
  health_check_grace_period = 60
  min_size               = var.ASG_Components["min_size"]
  max_size               = var.ASG_Components["max_size"]
  name                   = "Clixx-ASG${count.index}"

  tag {
    key                  = "Name"
    value                = "${local.ServerPrefix != "" ? local.ServerPrefix : "Clixx_Application_Server_"}${count.index}"
    propagate_at_launch  = true
  }
}


