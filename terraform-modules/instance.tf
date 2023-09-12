resource "aws_instance" "instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    ##security_groups = [aws_security_group.roboshop.name] ## to call the security group file sg.tf

   
}