
provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "my_eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = { Service = "eks.amazonaws.com" },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_role_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_subnet" "subnet1" {
  vpc_id            = "my_vpc_id"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = "my_vpc_id"
  availability_zone = "us-east-1b"
}
