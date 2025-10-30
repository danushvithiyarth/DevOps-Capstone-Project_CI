output "public_IP_Machine-1" {
  value = module.module.Machine-1-output
}

output "public_IP_Machine-2" {
  value = module.module.Machine-2-output
}

output "public_IP_Machine-3" {
  value = module.module.Machine-3-output
}

output "cluster_endpoint" {
  value = module.module.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.module.cluster_certificate_authority_data
}
