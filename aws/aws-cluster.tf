resource "aws_eks_cluster" "gourmet" {
    name = "gourmet"
    role_arn = aws_iam_role.gourmet.arn

    vpc_config {
        security_group_ids = [aws_security_group.gourmet.id]
        subnet_ids = aws_subnet.gourmet[*].id
    }
}

resource "aws_eks_node_group" "gourmet" {
    cluster_name = aws_eks_cluster.gourmet.name
    node_group_name = "gourmet"
    node_role_arn = aws_iam_role.gourmet.arn
    subnet_ids = aws_subnet.gourmet[*].id

    scaling_config {
      desired_size = 2
      max_size = 10
      min_size = 2
    }
}