aws ec2 create-vpc --cidr-block '10.0.0.0/16' \
    --tag-specifications ResourceType="vpc",Tags=[{Key=name,Value=vpc1}