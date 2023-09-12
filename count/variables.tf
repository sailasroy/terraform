variable "ami_id" {
    default = "ami-03265a0778a880afb"  

}

variable "instance_names" {
    type = list 
    default = ["Mongodb","Catalogue","Cart","Mysql","Redis"]
  
}

variable "instance_type" {
    #type = list
    default = "t2.micro"
  
}

variable "zone_id" {
    default = "Z02662462B6M0IFT9U3J6"
  
}

variable "domain" {
    default = "sailasdevops.online"
  
}

# variable "instance_names" {
#     type = list 
#     default = ["Mongodb","Cart","Catalogue","Mysql","Redis"]
  
# }

# variable "tags" {
#     type = map
#     default = {
#         Name = "Mongodb"
#         Environment = "DEV"
#         Component = "Mongodb"
#         Terraform = "true"
#         Project = "Roboshop"
# }
  

