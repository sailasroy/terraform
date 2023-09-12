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
        Redis = "t2.micro"
    }
  
}
variable "zone_id" {
    default = "Z02662462B6M0IFT9U3J6"
  
}

variable "domain" {
    default = "sailasdevops.online"
  
}


variable "ingress" {
    type = list 
    default = [
        {
            description      = "Allowing all HTTP ports"
            from_port        = 80  
            to_port          = 80
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        } ,
        {
            description      = "Allowing all HTTPS ports"
            from_port        = 443  
            to_port          = 443
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        } ,
        {
            description      = "Allowing all SSH ports"
            from_port        = 22  
            to_port          = 22
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
        }
    ]
  
}