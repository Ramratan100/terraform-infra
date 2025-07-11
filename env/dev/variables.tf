variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy for the VPC instances"
  type        = string
  default     = "default"
}

variable "enable_network_address_usage_metrics" {
  description = "Enable network address usage metrics for the VPC"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name prefix for the resources"
  type        = string
}

variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "route53_zone" {
  description = "Private Route53 zone name"
  type        = string
  default     = "non-prod.internal"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "database_subnets" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
}

variable "additional_public_routes" {
  description = "Additional routes for public subnets"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}

variable "additional_private_routes" {
  description = "Additional routes for private subnets"
  type = list(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = []
}

variable "flow_logs_enabled" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_logs_traffic_type" {
  description = "Type of traffic for VPC Flow Logs"
  type        = string
  default     = "ALL"
}

variable "flow_logs_file_format" {
  description = "File format for Flow Logs"
  type        = string
  default     = "parquet"
}
