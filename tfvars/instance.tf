resource "aws_instance" "roboshop" {
    for_each = var.instances
    ami = var.ami_id
    instance_type = each.value
    ##security_groups = [aws_security_group.roboshop.name] ## to call the security group file sg.tf

    tags = {
      Name = each.key
    }
}

resource "aws_route53_record" "record" {
    for_each = aws_instance.roboshop
    zone_id = var.zone_id
    name = "${each.key}.${var.domain}"
    type = "A"
    ttl  = 1
    records = [each.key == "Web" ? each.value.public_ip : each.value.private_ip]
  
}

resource "aws_security_group" "allow-all" {
    name = var.sg_name
    description = "allowing all ports" # you can keep this in variable

    ingress {
        description      = "Allowing all inbound traffic"
        from_port        = 0 # this is number
        to_port          = 0
        protocol         = "tcp"
        cidr_blocks      = var.sg_cidr
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" #all protocols
        cidr_blocks      = var.sg_cidr
    }
}