resource "aws_instance" "foreach" {
    for_each = var.instances
    ami = var.ami_id
    instance_type = each.value
    ##security_groups = [aws_security_group.roboshop.name] ## to call the security group file sg.tf

    tags = {
      Name = each.key
    }
}

resource "aws_route53_record" "record" {
    for_each = aws_instance.foreach
    zone_id = var.zone_id
    name = "${each.key}.${var.domain}"
    type = "A"
    ttl  = 1
    records = [each.key == "Redis" ? each.value.public_ip : each.value.private_ip]
  
}

# output "aws_instance_info" {
#     value = aws_instance.foreach
  
# }