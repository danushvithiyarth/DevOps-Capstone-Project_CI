output "deployment-machine-output" {
  value = aws_instance.deployment-machine.public_ip
}

output "sonar-nexux-output" {
  value = aws_instance.sonar-nexus.public_ip
}
