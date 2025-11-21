# Installing Amazon Plugin for Hashicorp to communicate with AWS via API: 
packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Passing Default Variables:
variable "instance_type" {
  type    = string
  default = "t2.xlarge"
}

variable "ami_region" {
  type    = string
  default = "ap-south-1"
}

variable "source_ami" {
  type    = string
  default = "ami-06c28eeae75712f2d"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_keypair_name" {
  type    = string
  default = "aws_testing_keypair" 
}

variable "ssh_private_key_file" {
  type    = string
  default = "/tmp/aws_packer_keypair.pem" # Update your key here. 
}

variable "vpc_id" {
  type    = string
  default = "vpc-0xxxxxxxxxxx1c7b" # Update this value.
}

variable "subnet_id" {
  type    = string
  default = "subnet-021xxxxxxxxxxxf6d" # Update this value.
}

variable "security_group_id" {
  type    = string
  default = "sg-0fxxxxxxxxxxx94" # Update this value.
}

# Amazon Builder Configuraiton:
source "amazon-ebs" "prometheus" {
  ami_name                    = "prometheus"
  instance_type               = var.instance_type
  region                      = var.ami_region
  source_ami                  = var.source_ami
  ssh_username                = var.ssh_username
  ssh_keypair_name            = var.ssh_keypair_name
  ssh_private_key_file        = var.ssh_private_key_file
  vpc_id                      = var.vpc_id
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  security_group_id           = var.security_group_id
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "Latest"
    Owner         = "Stalin Stepin"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Provisioner   = "Packer"
  }
}

# Invoking the builder
build {
  name    = "prometheus_build_using_packer"
  sources = ["source.amazon-ebs.prometheus"]

  provisioner "file" {
    # The below files.tar.gz file gets created only once the "build.sh" script is triggered. So, don't panic if you do not see this file.tar.gz in this repo. 
    # Also update the below directory path where the repo is cloned to. 
    source      = "/Users/sstepin/Quickstart_labs/packer_projects/prometheus/files/files.tar.gz" 
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "echo 'Uncompressing files'",
      "tar -C /tmp -zxvf /tmp/files.tar.gz > /dev/null 2>&1",
      "echo 'Completed uncompression!'",
      "sh /tmp/setup.sh"
    ]
  }
}