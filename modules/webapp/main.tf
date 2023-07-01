# Instance
resource "aws_instance" "webapp_instance" {
  count = length(var.private_subnet_ids)
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.webapp_alb_sg.id]
  key_name = var.key_name
  user_data = <<-EOT
  #!/bin/bash
  yum update -y
  amazon-linux-extras install nginx1.12 -y
  systemctl start nginx
  systemctl enable nginx
  EOT

  tags = {
    Name = "${var.environment}-webapp-instance-${count.index}"
  }
}

# AMI datasource
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# ALB SG
resource "aws_security_group" "webapp_alb_sg" {
  name = "${var.environment}-webapp-alb-sg"
  description = "HTTP in, all out"
  vpc_id = var.vpc_id 
  
  ingress {
    description = "HTTP from internet"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ALB 
resource "aws_lb" "webapp_alb" {
  name = "${var.environment}webapp-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.webapp_alb_sg.id]
  subnets = var.public_subnet_ids
}

# ALB TG
resource "aws_lb_target_group" "target_group" {
  name = "${var.environment}webapp-alb"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
    matcher = 200
  }
}

# ALB listener
resource "aws_alb_listener" "webapp_alb_listener" {
  load_balancer_arn = aws_lb.webapp_alb.id
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = {
    Name = "${var.environment}-webapp-alb-listener"
  }
}

# TG Attachment
resource "aws_lb_target_group_attachment" "webapp_tg_attachment" {
  count = length(var.private_subnet_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id = aws_instance.webapp_instance[count.index].id 
  port = 80
}
