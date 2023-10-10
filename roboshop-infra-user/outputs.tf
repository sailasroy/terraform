# output "vpc" {
#     value = module.vpc.vpc_id
  
# }

output "azs" {
    value = module.vpc.azs
  
}

output "public_subnet_ids" {
    value = local.public_subnet_ids
  
}

output "private_subnet_ids" {
    value = local.private_subnet_ids
  
}

output "database_subnet_ids" {
    value = local.database_subnet_ids
  
}

output "allow_all_security_group_id" {
    value = local.allow_all_security_group_id
     
}