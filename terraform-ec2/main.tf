module "ec2" {
    source = "../terraform-modules"
    ami_id = var.ami_id
    instance_type = var.instance_type
}