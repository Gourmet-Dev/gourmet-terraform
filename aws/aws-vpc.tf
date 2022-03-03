data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "gourmet" {
    cidr_block = "172.10.0.0/20"
    tags = tomap({
        "Name" = var.gourmet_id,
        "kubernetes.io/cluster/${var.gourmet_id}" = "shared"
    })
}

resource "aws_subnet" "gourmet" {
    count = 2

    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block = "172.10.${count.index}.0/24"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.gourmet.id

    tags = tomap({
        "Name" = var.gourmet_id,
        "kubernetes.io/cluster/${var.gourmet_id}" = "shared"
    })
}

resource "aws_internet_gateway" "gourmet" {
    vpc_id = aws_vpc.gourmet.id

    tags = {
        Name = var.gourmet_id
    }
}

resource "aws_route_table" "gourmet" {
    vpc_id = aws_vpc.gourmet.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gourmet.id
    }
}

resource "aws_route_table_association" "gourmet" {
    count = 2

    subnet_id = aws_subnet.gourmet.*.id[count.index]
    route_table_id = aws_route_table.gourmet.id
}