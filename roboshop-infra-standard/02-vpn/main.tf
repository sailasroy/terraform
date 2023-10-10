
# resource "aws_security_group_rule" "vpn" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   ##ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.vpn_sg.aws_security_group_id
# }


module "roboshop_vpn" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.devops_ami.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
    ## It will be installed in default vpn 
    ####subnet_id = local.public_subnet_ids[0]
   #### user_data = file("roboshop-ans.sh")

    tags = merge(
        {
            Name = "Roboshop_VPN"
        },
        var.common_tags
    )

}

 