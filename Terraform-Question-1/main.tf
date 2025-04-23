module "ec2_instances" {
  #source = "./terraform-ec2-module"
  source = "./modules/ec2_create"

  ec2_instances = {
    instance1 = {
      instance_type = "t2.micro"
      volume_type   = "gp2"
      volume_size   = 8
      key_name      = "key1"
    }
    instance2 = {
      instance_type = "t3.small"
      volume_type   = "gp3"
      volume_size   = 10
      key_name      = "key2"
    }
    instance3 = {
      instance_type = "m5.large"
      volume_type   = "io1"
      volume_size   = 20
      key_name      = "key3"
      iops          = 120
    }
    instance4 = {
      instance_type = "t2.medium"
      volume_type   = "gp2"
      volume_size   = 16
      key_name      = "key4"
    }
    instance5 = {
      instance_type = "c5.large"
      volume_type   = "io2"
      volume_size   = 30
      key_name      = "key5"
      iops          = 150
    }
  }
}