resource "aws_security_group" "gourmet" {
    name = "gourmet"
    description = "Security group for gourmet"
    vpc_id = aws_vpc.gourmet.id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.gourmet_id
    }
}

resource "aws_security_group_rule" "gourmet-ingress" {
    cidr_blocks = [var.management_cidr]
    description = "Allow ingress communications to management infrastructures."
    security_group_id = aws_security_group.gourmet.id
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
}