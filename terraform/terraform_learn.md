* File Extension
    * Code in the Terraform language is stored in plain text files with the .tf file extension

=============================================


terraform init
terraform validate
terraform apply
terraform destroy
===========
provider.tf ..............network.tf...........inputs.tf(for default variables)(not tfvars pls remind)


provider.tf  
```
provider  "aws"  {
    region      =  "us-west-2"
    access_key  =  "AKIA6JDG2BNMCVSG5Y3E"
    secret_key  =  "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"
}

```

inputs.tf = consists of variables with all descriptions and default valus
valus.tfvars = consists of values for all variables  and while apply we have to mention this for prod env one tfvars file , for dev other tfvar, for test other tfvar are created and apply acc to it `terraform apply -var-file=values.tfvars

```inputs.tf
# https://www.terraform.io/language/values/variables#number

variable "vpc_name" {
  type    = string
  default = "terraformvpc_practice"
}

variable "subnet_name" {
  type    = list(string)
  default = ["web1","web2","app1","app2","db1","db2"]
}

variable "vpc_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_range" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a","us-west-1b"]
}


```

test.tfvars
```
vpc_name = "vpc_practice"
vpc_cidr_range = "12.0.0.0/16"
subnet_cidr_range = ["12.0.1.0/24","12.0.2.0/24","12.0.3.0/24","12.0.4.0/24","12.0.5.0/24","12.0.6.0/24"]
```

.tfvars file overrides the default values

if tfvars file is using then there is no need of mentioning default argument and values in input.tf file here for eg as all defaults mentioned in .tfvars file itself



terraform console