resource "aws_security_group_rule" "allow_control_plane_to_nodes" {
  description              = "Allow EKS Control Plane to reach worker nodes"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = "sg-03467cb08ee3df626"   # Worker nodes SG
  source_security_group_id = "sg-0bd62af49002eacbe"   # Control plane SG
}

