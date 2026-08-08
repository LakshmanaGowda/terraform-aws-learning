variable "security_group_name" {
  description = "Name of the Security Group"
  type        = string
}

variable "description" {
  description = "Security Group description"
  type        = string
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(number)
}
