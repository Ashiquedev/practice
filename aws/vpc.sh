
aws ec2 create-vpc \
     --cidr-block '10.0.0.0/16' \
    --tag-specifications ResourceType=vpc,Tags='[{Key=Name,Value="vpc1"}]'

#"VpcId": "vpc-0da7bd914530a3577"

aws ec2 create-subnet \
    --tag-specifications ResourceType="subnet",Tags='[{Key=Name,Value="web1"}]' \
    --availability-zone 'ap-southeast-1a' \
    --cidr-block '10.0.1.0/24' \
    --vpc-id "vpc-0da7bd914530a3577"           #"SubnetId": "subnet-0ee799957bb41075a"


aws ec2 create-subnet \
    --tag-specifications ResourceType="subnet",Tags='[{Key=Name,Value="db1"}]' \
    --availability-zone 'ap-southeast-1a' \
    --cidr-block '10.0.2.0/24' \
    --vpc-id "vpc-0da7bd914530a3577"           #"SubnetId": "subnet-0e022f40c55ce7f3d"


aws ec2 create-subnet \
    --tag-specifications ResourceType="subnet",Tags='[{Key=Name,Value="web2"}]' \
    --availability-zone 'ap-southeast-1b' \
    --cidr-block '10.0.3.0/24' \
    --vpc-id "vpc-0da7bd914530a3577"           #"SubnetId": "subnet-09b4e7c16507696fb""

aws ec2 create-subnet \
    --tag-specifications ResourceType="subnet",Tags='[{Key=Name,Value="db2"}]' \
    --availability-zone 'ap-southeast-1b' \
    --cidr-block '10.0.4.0/24' \
    --vpc-id "vpc-0da7bd914530a3577"     #"SubnetId": "subnet-0119ba5cab083c344"

aws ec2 create-internet-gateway \      #"InternetGatewayId": "igw-079c5b2599907ca43"
    --tag-specifications ResourceType="internet-gateway",Tags='[{Key=Name,Value="task1_vpc1_igw"}]'

aws ec2 attach-internet-gateway \
    --internet-gateway-id "igw-079c5b2599907ca43" \
    --vpc-id "vpc-0da7bd914530a3577"


aws ec2 create-route-table \
    --vpc-id "vpc-0da7bd914530a3577" \
    --tag-specifications ResourceType="route-table",Tags='[{Key=Name,Value="public_rt"}]'   # "RouteTableId": "rtb-09116a2238e1db705"


aws ec2 create-route-table \
    --vpc-id "vpc-0da7bd914530a3577" \
    --tag-specifications ResourceType="route-table",Tags='[{Key=Name,Value="private_rt"}]'  # "RouteTableId": "rtb-0118bd65076701421",



aws ec2 associate-route-table \
        --route-table-id "rtb-09116a2238e1db705" \
        --subnet-id "subnet-0119ba5cab083c344"
        
aws ec2 associate-route-table \
        --route-table-id "rtb-09116a2238e1db705" \        
        --subnet-id "subnet-0ee799957bb41075a"
aws ec2 associate-route-table \
        --route-table-id "rtb-09116a2238e1db705" \ 
        --subnet-id "subnet-0e022f40c55ce7f3d"
aws ec2 associate-route-table \
        --route-table-id "rtb-09116a2238e1db705" \        
        --subnet-id "subnet-09b4e7c16507696fb"
aws ec2 associate-route-table \
        --route-table-id "rtb-09116a2238e1db705" \        
        --subnet-id "subnet-0119ba5cab083c344"
aws ec2  create-instance \
    --instance-type "t2.micro" \
    --count 2 \
    --ami-id "ami-04505e74c0741db8d" \
    --ssh-key-name "practice.pem" \
    --availability-zone "ap-southeast-1a" \
    --subnet-id "subnet-0ee799957bb41075a" \
    --architecture "x86_64"