resource "aws_instance" "condition" {
    #count = 5
    ami = var.ami_id
    instance_type = var.instance_name == "Mongodb" ? "t3.medium" : "t2.micro"
    #tags = var.tags
}