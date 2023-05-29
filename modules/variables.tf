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

# variable "db_user" {
#   description = "The administrator username for the database."
#   type        = string
# }

# variable "db_password" {
#   description = "The administrator password for the database."
#   type        = string
# }

# variable "wp_user" {
#   description = "The administrator password for the database."
#   type        = string
# }

# variable "wp_password" {
#   description = "The administrator password for the database."
#   type        = string
# }