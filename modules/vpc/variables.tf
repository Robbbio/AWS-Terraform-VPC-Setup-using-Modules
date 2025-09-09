variable "cidr_block" {
  type = string    
}

variable "int_cidr" {
  type = string    
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "project_name"{
  type = string    
}

variable "engineer"{
  type = string    
}

variable "project_code"{
  type = string    
}
