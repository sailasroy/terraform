variable "ami_id" {
    default = "ami-03265a0778a880afb"  

}

variable "instance_name" {
    default = "Cart"
  
}

variable "instance_type" {
    #type = list
    default = "t2.micro"
  
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
  

