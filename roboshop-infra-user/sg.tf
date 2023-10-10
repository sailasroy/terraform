module "allow_all_sg" {
    source = "../aws-security-groups"
    project_name = var.project_name
    sg_name = "allow-all"
    sg_description = "Allow all traffic from internet"
    sg_ingress_rules = var.sg_ingress_rules
    vpc_id = local.vpc_id
    common_tags = var.common_tags
}