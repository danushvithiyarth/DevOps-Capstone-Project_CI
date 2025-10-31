resource "aws_security_group_rule" "allow_ec2_to_eks_api" {
  description              = "Allow EC2 bastion to access private EKS API"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.Machine-3-securitygroup.id
  security_group_id        = "sg-070ea8267cd1a244e"
}

resource "aws_security_group_rule" "allow_api_to_vault_injector" {
  description              = "Allow EKS API server to reach Vault Agent Injector on worker nodes"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "sg-08fa8e70deafa4e04"        # Worker nodes SG
  source_security_group_id = "sg-070ea8267cd1a244e"        # EKS control plane SG
}
