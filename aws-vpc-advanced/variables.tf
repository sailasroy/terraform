variable "cidr_block" {
  
}

variable "enable_dns_hostnames" {
    default = true
  
}

variable "enable_dns_support" {
    default = true
  
}

variable "common_tags" {
    default = {}
}

variable "project_name" {
    
  
}

variable "igw_tags" {
    default = {}
  
}

variable "public_subnet_cidr" {
validation {
    condition = length(var.public_subnet_cidr) == 2
    error_message = "Please provide 2 public subnet cidr"
  } 
  
}

variable "private_subnet_cidr" {
validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "Please provide 2 private subnet cidr"
  } 
  
}

variable "database_subnet_cidr" {
    validation {
      condition = length(var.database_subnet_cidr) == 2
      error_message = "Please provide 2 database subnet cidr"
    }
  
}
variable "is_peering_required" {
    default = false
  
}

 

variable "requestor_vpc_id" {
  
}

variable "default_route_table_id" {
  
}

variable "default_cidr_block" {
    
  
}