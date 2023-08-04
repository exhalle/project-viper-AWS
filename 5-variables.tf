variable "environment" {
  description = "test-env"
}

variable "pathtocred" {
}
variable "profile" {
  type = string
}

variable "region" {
  type = string

}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {

  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {

  description = "CIDR block for Private Subnet"
}

# variable "region" {
#   description = "Region in which the bastion host will be launched"
#   default     = eu-central-1
#}

variable "availability_zones" {
  type        = list(any)
  description = "AZ in which all the resources will be deployed"
}


# VARS FOR DB
variable "db_username" {
  type = string

}

variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_identifier" {
  type = string

}

# VARS FOR BEANSTALK

variable "elasticapp" {
  default = "myapp"
}
variable "beanstalkappenv" {
  default = "appviper"
}
variable "solution_stack_name" {
  type    = string
  default = "64bit Amazon Linux 2 v4.3.9 running Tomcat 8.5 Corretto 8"
}

variable "urls3bucketapp" {
  type = string
}


