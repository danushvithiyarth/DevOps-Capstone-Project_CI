data "http" "my_ip" {
  url = "https://ifconfig.me"
}

locals {
  my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"
}

