packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  region          = "ap-southeast-2"
  ami_name        = "ami-version-1.0.1-{{timestamp}}"
  instance_type   = "t2.micro"
  source_ami      = "ami-0d6294dcaac5546e4"
  ssh_username    = "ec2-user"
  ami_regions     = [
    "ap-southeast-2"
  ]
}

build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}
