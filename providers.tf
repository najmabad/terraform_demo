terraform {
  required_providers {
  # in theory, we could avoid specifying the provider here because it's part of the official Terraform registry
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
    # this needs to be specified because it's not part of the official Terraform registry
    linode = {
        source = "linode/linode"
        version = "2.31.1"
      }
}
}
