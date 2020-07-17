# Resource to create a instances
resource "aws_launch_configuration" "this" {
  name_prefix                 = "autoscaling-launcher"
  image_id                    = var.ami
  instance_type               = var.family
  key_name                    = var.key_ssh
  security_groups             = [aws_security_group.sg_alb.id]
  associate_public_ip_address = true
}
# How much instances do you need? Create a limit on MaxSize
# This add instances on target group of load balancer
resource "aws_autoscaling_group" "this" {
  name                      = "terraform-autoscaling"
  vpc_zone_identifier       = [element(module.vpc.public_subnets, 0), element(module.vpc.public_subnets, 1)]
  launch_configuration      = aws_launch_configuration.this.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.tg.arn]
}
# Policy to create a new machine
# Maybe you need consult this knowledge about scaling policy
# https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scale-based-on-demand.html
resource "aws_autoscaling_policy" "scaleup" {
  name                   = "Scale Up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
# Policy Downsize
resource "aws_autoscaling_policy" "scaledown" {
  name                   = "Scale Down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# ATETION this data can get empty value!
# Get some informations about instances
data "aws_instances" "all" {
  filter {
    name   = "image-id"
    values = [var.ami]
  }
  instance_state_names = ["running", "pending"]

  depends_on = [
    aws_launch_configuration.this, aws_lb_listener.lbl
  ]
}
# Show ips of instances
output "aws_instance" {
  value = data.aws_instances.all.public_ips
}