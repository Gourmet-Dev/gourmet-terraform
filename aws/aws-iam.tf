resource "aws_iam_role" "gourmet" {
    name = "gourmet"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com",
                    "eks.amazonaws.com"
                ]
            }
        }
    ]
}
POLICY
}

# Cluster
resource "aws_iam_role_policy_attachment" "gourmet-AmazonEKSVPCResourceController" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role = aws_iam_role.gourmet.name
}

# Cluster
resource "aws_iam_role_policy_attachment" "gourmet-AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.gourmet.name
}

# WorkerNode
resource "aws_iam_role_policy_attachment" "gourmet-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.gourmet.name
}

# WorkerNode
resource "aws_iam_role_policy_attachment" "gourmet-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.gourmet.name
}

# WorkerNode
resource "aws_iam_role_policy_attachment" "gourmet-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.gourmet.name
}