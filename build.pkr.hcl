source "amazon-ebs" "nginx-golden" {
  region = "ap-northeast-2"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "RHEL-8*-x86_64-*"
      root-device-type    = "ebs"
    }
    owners      = ["309956199498"]
    most_recent = true
  }
  instance_type  = "t3.medium"
  ssh_username   = "redhat_nginx"
  ssh_agent_auth = false

  ami_name    = "hashicups_{{timestamp}}"
  ami_regions = ["ap-northeast-2"]
  run_tags = {
    Schedule = "off-at-20"
  }
}

build {
  # HCP Packer settings
  hcp_packer_registry {
    bucket_name = "learn-packer-github-actions"
    description = <<EOT
This is an image for HashiCups.
    EOT

    bucket_labels = {
      "hashicorp-learn" = "learn-packer-github-actions",
    }
  }

  sources = [
    "source.amazon-ebs.nginx-golden",
  ]
}
