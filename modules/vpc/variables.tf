variable "vpc_name" {
  type = string
}

variable "azs" {
  type        = list(string)
  description = "availability zones"
  validation {
    condition     = length(var.azs) >= 3
    error_message = "Need at least 3 availability zones"
  }
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "public subset CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # validation {
  #   condition     = length(var.azs) == length(var.public_subnet_cidrs)
  #   error_message = "Must have the same number of subnet cidrs as AZs"
  # }
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "public subset CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  # validation {
  #   condition     = length(var.azs) == length(var.private_subnet_cidrs)
  #   error_message = "Must have the same number of subnet cidrs as AZs"
  # }
}
