output "Machine-1-output" {
  value = aws_instance.Machine-1.public_ip
}

output "Machine-2-output" {
  value = aws_instance.Machine-2.public_ip
}

output "Machine-3-output" {
  value = aws_instance.Machine-3.public_ip
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
