variable "ami" {
  description = "AMI"
  type        = string
  default = "ami-00463ddd1036a8eb6"
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default = "t2.micro"
}