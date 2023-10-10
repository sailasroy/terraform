variable "env" {
    default = "dev"
  
}

variable "common_tags" {
    default = {
        Project = "roboshop"
        Component = "redis"
        Environment = "DEV"
        Terraform = "true"
    }
  
}

variable "project_name" {
    default = "roboshop"
  
}

variable "zone_name"{
    default = "sailasdevops.online"
  
}