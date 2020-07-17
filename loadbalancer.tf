# Resource of Subnets 
resource "aws_lb" "lb" {
  name            = "alb"
  security_groups = [aws_security_group.sg_alb.id]
  subnets         = [element(module.vpc.public_subnets, 0), element(module.vpc.public_subnets, 1)]
  # Export URL LoadBalancer to a file
  # Use this to easy access web
  provisioner "local-exec" {
    command = "echo ${aws_lb.lb.dns_name} > url-loadbalancer.txt"
  }
}
# Create a Target Group AutoScaling need this to attach instances
resource "aws_lb_target_group" "tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    port                = 80
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 4
    interval            = 5
    matcher             = "200"
  }
}
# You can hear something? If no, make a forward to another instance
resource "aws_lb_listener" "lbl" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
# Export URL DNS Name to access on WebBrowser
output "dns_name" {
  value = aws_lb.lb.dns_name
}