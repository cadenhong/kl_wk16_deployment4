variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  type = string
}

variable "vpc-cidr" {
  type = string
}

variable "sub1-cidr" {
  type = string
}

variable "sub2-cidr" {
  type = string
}

variable "ec2-properties" {
  type = map(string)
}