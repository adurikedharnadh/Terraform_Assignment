variable "ec2_instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
    iops          = optional(number)
  }))
}