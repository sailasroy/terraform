module "this" {
    source = "../terraform-aws-vpc"
    cidr_block = var.cidr_block
    common_tags = var.common_tags
    vpc_tags = var.vpc_tags
    igw_tags = var.internet_gateway_tags

    # Availability Zones Creaton
    azs = var.azs

    # Public Sunets Creation
    public_subnet_cidr = var.public_subnet_cidr
    public_subnet_names = var.public_subnet_names

    # Private Sunets Creation
    private_subnet_cidr = var.private_subnet_cidr
    private_subnet_names = var.private_subnet_names

    # Database Sunets Creation
    database_subnet_cidr = var.database_subnet_cidr
    database_subnet_names = var.database_subnet_names



    public_route_table_tags = var.public_route_table_tags
    private_route_table_tags = var.private_route_table_tags
    database_route_table_tags = var.database_route_table_tags




}