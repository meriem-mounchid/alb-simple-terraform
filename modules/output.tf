output "instance_ip" {
  value = aws_instance.my_web_server.public_ip
}

output "instance_ip2" {
  value = aws_instance.my_web_server2.public_ip
}

output "lb_name" {
  value = aws_lb.alb.dns_name
}
