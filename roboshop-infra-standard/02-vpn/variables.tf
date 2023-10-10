variable "common_tags" {
    default = {
        Project = "roboshop"
        Component = "vpn"
        Environment = "DEV"
        Terraform = "true"
    }
  
}

variable "project_name" {
    default = "roboshop"
  
}
variable "env" {
    default = "dev"
  
}