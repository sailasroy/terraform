output "private_ips" {
    value = aws_instance.condition[*].private_ip
  
}