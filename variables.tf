variable "aws_region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
}

variable "project_name" {
  default = "TerraformWebsite"
}
