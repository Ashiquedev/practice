# https://www.terraform.io/language/values/variables#number

variable "vpc_name" {
  type    = string
  #default = "terraformvpc_practice"
}

variable "subnet_name" {
  type    = list(string)
  default = [ "web1","web2","app1","app2","db1","db2" ]
}

variable "vpc_cidr_range" {
  type    = string
  #default = "10.0.0.0/16"
}

variable "public_subnet_names" {
  type    = list(string)
  default = [ "web1","web2" ]
}


variable "vpc_region" {
  type = string
  default = "ap-southeast-1"  
}



