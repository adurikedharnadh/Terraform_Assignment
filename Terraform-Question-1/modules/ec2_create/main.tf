provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "this" {
  for_each = var.ec2_instances

  ami = data.aws_ssm_parameter.ubuntu_22_04.value
  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops = contains(["io1", "io2"], each.value.volume_type) ? each.value.iops : null
  }

  tags = {
    Name = each.key
  }
}

data "aws_ssm_parameter" "ubuntu_22_04" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
