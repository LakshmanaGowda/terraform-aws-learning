variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data script for EC2 instance"
  type        = string
  default     = ""
}
