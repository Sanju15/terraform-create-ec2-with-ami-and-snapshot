variable "instance_type" {
  type    = string
  default = "t3a.medium"
}

variable "subnet_id" {
  description = "Subnet id"
}

variable "vpc_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "name_prefix" {
  type = string
  default = "my-project"
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "security_group_id" {
  description = "security group id"
}

variable "environment" {
  description = "Environment"
}
