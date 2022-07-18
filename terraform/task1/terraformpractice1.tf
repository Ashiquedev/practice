resource "aws_vpc" "terraformvpc" {
  cidr_block = var.vpc_cidr_range
   tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.subnet_name)
    vpc_id     = aws_vpc.terraformvpc.id
    cidr_block = cidrsubnet(var.vpc_cidr_range,8,count.index)
    availability_zone = format("${var.vpc_region}%s", count.index%2==0 ? "a":"b")

    tags = {
      Name = var.subnet_name[count.index]
  }
}


resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraformvpc.id

  tags = {
    Name = "terraform_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraformvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.terraformvpc.id
  tags = {
    Name = "private_rt"
  }
}
resource "aws_route_table_association" "public_rt_subnet_associations" {
  route_table_id = aws_route_table.public_rt.id
  count = length(var.public_subnet_names)
    data "aws_subnet_ids" "public_subnets_ids" {  
      vpc_id = aws_vpc.terraformvpc.id
          filter {
              name = "tag:Name"
              values = [ var.public_subnet_names.count.index ]
              }
          }
    subnet_id      = data.aws_subnet_ids.public_subnets_ids.ids
} 
#resource "aws_route_table_association" "private_rt_subnet_associations" {
#  subnet_id      = aws_subnet.foo.id
#  route_table_id = aws_route_table.bar.id
#}