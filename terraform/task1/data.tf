#data "aws_subnets" "public_subnets_ids" {  
#    vpc_id = aws_vpc.terraformvpc.id
#        filter {
#            name = "tag:Name"
#            values = var.public_subnet_names
#            }
#        }
#
#output "public_sn_ids" {
#    value = data.aws_subnet_ids.public_subnets_ids.ids
#}