resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = merge(
        var.common_tags,
        var.vpc_tags
    )
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = merge(
        var.common_tags,
        var.igw_tags
    )
}
    ## 2 Public subnets creation

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.public_subnet_names[count.index]

        }
    )
}
    ## 2 Private subnets creation

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.private_subnet_names[count.index]
        }
    )
}


resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidr)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.database_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags = merge(
        var.common_tags,
        {
            Name = var.database_subnet_names[count.index]
        }
    )
}

 resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
 

  tags = merge(
        var.common_tags,
        var.public_route_table_tags
    )
}

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
  depends_on                = [aws_route_table.public]
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
 

  tags = merge(
        var.common_tags,
        var.private_route_table_tags
    )
}
resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidr)
    subnet_id = element(aws_subnet.private[*].id,count.index)
    route_table_id = aws_route_table.private.id
    }

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
 

  tags = merge(
        var.common_tags,
        var.database_route_table_tags
    )
}

resource "aws_route_table_association" "database" {
    count = length(var.database_subnet_cidr)
    subnet_id = element(aws_subnet.database[*].id,count.index)
    route_table_id = aws_route_table.database.id
    }