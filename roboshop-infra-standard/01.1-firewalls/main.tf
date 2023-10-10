module "vpn_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "roboshop-vpn1"
    sg_description = "Allow all traffic from my laptop"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_vpc.default.id
    common_tags = merge (var.common_tags,
    {
        Component : "VPN"
        Name : "Roboshop-VPN"
    }
    )
}

module "mongodb_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "mongodb"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "Mongodb"
        Name : "Mongodb"
    }
)
}

module "catalogue_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "catalogue"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge ( var.common_tags,
    {
        Component : "Catalogue"
        Name : "Catalogue"
    }
    )
}

module "web_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "web"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "Web"
        Name : "Web"
    }
    )
}
module "redis_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "redis"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "Redis"
        Name : "Redis"
    }
    )
}

module "user_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "user"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "User"
        Name : "User"
    }
    )
}

module "cart_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "cart"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "User"
        Name : "User"
    }
    )
}

module "mysql_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "mysql"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "Mysql"
        Name : "Mysql"
    }
    )
}


module "shipping_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "shipping"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "shipping"
        Name : "shipping"
    }
    )
}

module "rabbitmq_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "rabbitmq"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "rabbitmq"
        Name : "rabbitmq"
    }
    )
}

module "payments_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "payments"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "payments"
        Name : "payments"
    }
    )
}

module "app_alb_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "App-ALB"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge(var.common_tags,
    {
        Component : "APP"
        Name : "App-ALB"
    }
    )
}


module "web_alb_sg" {
    source = "../../aws-security-groups"
    project_name = var.project_name
    sg_name = "Web-ALB"
    sg_description = "Allowing Tarffic"
    ##sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = merge( var.common_tags,
    {
        Component : "WEB"
        Name : "Web-ALB"
    }
    )
}

resource "aws_security_group_rule" "vpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.vpn_sg.aws_security_group_id
}

# This is allowing connections from all catalogue instances to MongoDB
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  description = "Allowing port number 27017 from catalogue"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.aws_security_group_id
}

# This is allowing connections from all Mongodb instances to vpn
resource "aws_security_group_rule" "mongodb_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from  mongodb"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.aws_security_group_id
}

# This is allowing connections from all catalogue instances to vpn
resource "aws_security_group_rule" "catalogue_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from catalogue"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.aws_security_group_id
}

# This is allowing connections from all catalogue instances to app-alb
resource "aws_security_group_rule" "catalogue_app_alb" {
  type              = "ingress"
  description = "Allowing port number 8080 from catalogue"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.catalogue_sg.aws_security_group_id
}

# This is allowing connections from all App-alb instances to vpn
resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  description = "Allowing port number 80 from app-alb"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.aws_security_group_id
}


# This is allowing connections from all App-alb instances to web
resource "aws_security_group_rule" "app_alb_web" {
  type              = "ingress"
  description = "Allowing port number 80 from web"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.app_alb_sg.aws_security_group_id
}


# This is allowing connections from all web instances to vpn
resource "aws_security_group_rule" "web_vpn" {
  type              = "ingress"
  description = "Allowing port number 80 from web"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.aws_security_group_id
}

# This is allowing connections from all web instances to vpn
resource "aws_security_group_rule" "web_vpn_ssh" {
  type              = "ingress"
  description = "Allowing port number 22 from web"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.aws_security_group_id
}

# This is allowing connections from all web instances to web-alb
resource "aws_security_group_rule" "web_web_alb" {
  type              = "ingress"
  description = "Allowing port number 80 from web-alb"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_sg.aws_security_group_id
}
resource "aws_security_group_rule" "web_alb_internet" {
  type              = "ingress"
  description = "Allowing port number 80 from Internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.aws_security_group_id
}

resource "aws_security_group_rule" "web_alb_internet_https" {
  type              = "ingress"
  description = "Allowing port number 443 from Internet"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.web_alb_sg.aws_security_group_id
}

# This is allowing connections from all Redis instances to vpn
resource "aws_security_group_rule" "redis_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from redis to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.aws_security_group_id
}

# This is allowing connections from all vpn instances to user
resource "aws_security_group_rule" "user_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from user to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.aws_security_group_id
}

# This is allowing connections from all redis instances to user
resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  description = "Allowing port number 6379 from redis to user"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.user_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.aws_security_group_id
}

# This is allowing connections from all user instances to app-alb
resource "aws_security_group_rule" "user_app_alb" {
  type              = "ingress"
  description = "Allowing port number 8080 from app-alb to user"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.user_sg.aws_security_group_id
}

# This is allowing connections from all mongodb instances to user
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  description = "Allowing port number 27017 from mongodb to user"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.user_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mongodb_sg.aws_security_group_id
}


# This is allowing connections from all vpn instances to cart
resource "aws_security_group_rule" "cart_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from cart to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.aws_security_group_id
}

# This is allowing connections from all redis instances to cart
resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  description = "Allowing port number 6379 from redis to cart"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.cart_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.redis_sg.aws_security_group_id
}

# This is allowing connections from all user instances to app-alb
resource "aws_security_group_rule" "cart_app_alb" {
  type              = "ingress"
  description = "Allowing port number 8080 from app-alb to cart"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.cart_sg.aws_security_group_id
}


# This is allowing connections from all vpn instances to mysql
resource "aws_security_group_rule" "mysql_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from mysql to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mysql_sg.aws_security_group_id
}

# This is allowing connections from all vpn instances to shipping
resource "aws_security_group_rule" "shipping_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from mysql to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.shipping_sg.aws_security_group_id
}

# This is allowing connections from all mysql instances to shipping
resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  description = "Allowing port number 3306 from mysql to shipping"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.shipping_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.mysql_sg.aws_security_group_id
}

# This is allowing connections from all rabbitmq instances to vpn
resource "aws_security_group_rule" "rabbitmq_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from rabbitmq to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.rabbitmq_sg.aws_security_group_id
}

# This is allowing connections from all rabbitmq instances to vpn
resource "aws_security_group_rule" "payments_vpn" {
  type              = "ingress"
  description = "Allowing port number 22 from payments to vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payments_sg.aws_security_group_id
}

# This is allowing connections from all catalogue instances to app-alb
resource "aws_security_group_rule" "payments_app_alb" {
  type              = "ingress"
  description = "Allowing port number 8080 from payments"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.aws_security_group_id
  #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = module.payments_sg.aws_security_group_id
}

# # This is allowing connections from all App-alb instances to catalogue
# resource "aws_security_group_rule" "app_alb_catalogue" {
#   type              = "ingress"
#   description = "Allowing port number 80 from catalogue"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.catalogue_sg.aws_security_group_id
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.app_alb_sg.aws_security_group_id
# }

# # This is allowing connections from all App-alb instances to web
# resource "aws_security_group_rule" "app_alb_user" {
#   type              = "ingress"
#   description = "Allowing port number 80 from user"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.user_sg.aws_security_group_id
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.app_alb_sg.aws_security_group_id
# }

# # This is allowing connections from all App-alb instances to cart
# resource "aws_security_group_rule" "app_alb_cart" {
#   type              = "ingress"
#   description = "Allowing port number 80 from cart"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.cart_sg.aws_security_group_id
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.app_alb_sg.aws_security_group_id
# }

# # This is allowing connections from all App-alb instances to cart
# resource "aws_security_group_rule" "app_alb_shipping" {
#   type              = "ingress"
#   description = "Allowing port number 80 from shipping"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.shipping_sg.aws_security_group_id
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.app_alb_sg.aws_security_group_id
# }

# # This is allowing connections from all App-alb instances to cart
# resource "aws_security_group_rule" "app_alb_payments" {
#   type              = "ingress"
#   description = "Allowing port number 80 from payments"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.payments_sg.aws_security_group_id
#   #cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
#   #ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
#   security_group_id = module.app_alb_sg.aws_security_group_id
# }