variable "ami_id" {
    default = "ami-03265a0778a880afb"
  
}


variable "instances" {
    type = map 
    default = {
        Mongodb = "t3.medium"
        Cart = "t2.micro"
        Mysql = "t3.medium"
        Catalogue = "t2.micro"
        Web = "t2.micro"
    }
  
}
variable "zone_id" {
    default = "Z02662462B6M0IFT9U3J6"
  
}

variable "domain" {
    default = "sailasdevops.online"
  
}

variable "sg_cidr" {
    default = ["0.0.0.0/0"]
  
}

 variable "sg_name" {
    default = "allow-all"
   
 }
  
 