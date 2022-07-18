locals {
  ssh_port          = 22
  db_port           = 3306
  app_port          = 8080
  web_port          = 80
  tcp_protocol      = "tcp"
  anywhere          =  ["0.0.0.0/0"]
  egress_from_port  = 0
  egress_to_port  = 0
  any_protocol      = -1
}