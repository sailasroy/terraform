resource "aws_instance" "my-wish" {
    ami = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.allow_all.name]
  }

# resource "aws_instance" "my-wish" {
#     ami = "ami-03265a0778a880afb"
#     instance_type = "t2.micro"
  
# }