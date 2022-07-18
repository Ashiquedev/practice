resource "aws_security_group" "webserver_sg" {
  description = "security group for web allowing ssh,http"
  egress {
    from_port = local.egress_from_port
    to_port     = local.egress_to_port
    cidr_blocks = local.anywhere
    protocol = local.any_protocol
  }
  ingress {
    from_port = local.ssh_port
    to_port = local.ssh_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  ingress {
    from_port = local.web_port
    to_port = local.web_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  tags = {
    Name = "webserver_sg"
  }
}
resource "aws_security_group" "appserver_sg" {
  description = "security group for app tomcat 0n 8080"
  egress {
    from_port = local.egress_from_port
    to_port     = local.egress_to_port
    cidr_blocks = local.anywhere
    protocol = local.any_protocol
  }
  ingress {
    from_port = local.ssh_port
    to_port = local.ssh_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  ingress {
    from_port = local.app_port
    to_port = local.app_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  tags = {
    Name = "appserver_sg"
  }
}
resource "aws_security_group" "dbserver_sg" {
  description = "security group for mysql db allowing 3306"
  egress { #connecting a machine inside vpn
    from_port = local.egress_from_port  # from is the outside the network
    to_port     = local.egress_to_port
    cidr_blocks = local.anywhere
    protocol = local.any_protocol
  }
  ingress {
    from_port = local.ssh_port
    to_port = local.ssh_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  ingress {
    from_port = local.db_port
    to_port = local.db_port
    protocol = local.tcp_protocol
    cidr_blocks = local.anywhere
  }
  tags = {
    Name = "dbserver_sg"
  }
}