variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
}
variable "userdata_file" {
  type = string
}

variable "availability_zone" {
  description = "The availability zone for the subnet."
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ports for ingress rules."
  type        = list(number)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet."
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group."
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance."
  type        = string
}
variable "user_data" {
  type = string
}
