# Terraform template
### Diagram
![Diagram](/terraform_task/diagram.png)

### This template deploys:
+ VPC
+ Subnets
+ Gateways (nat and internet gateway)
+ Security group
+ Network acl
+ Instances
+ Target group
+ Load ballancer

### VPC
This template create VPC with 10.10.0.0/16 CIDR and tag name "LB_VPC"  

### Subnets
5 subnets are created inside the VPC in different availability zones: 
+ ```lb_nat_1``` (10.10.1.0/24, us-east-2a) - first private subnet for instances
+ ```lb_nat_2``` (10.10.2.0/24, us-east-2b) - second private subnet for instances
+ ```lb_net_1``` (10.10.3.0/24, us-east-2a) - first public subnet for load balancer
+ ```lb_net_2``` (10.10.4.0/24, us-east-2b) - second public subnet for load balancer
+ ```lb_net_3``` (10.10.5.0/24, us-east-2c) - public subnet for nat gateway (Dedicated segment for fault tolerance and monitoring)

### Gateways
+ ```lb_gw``` - internet gateway
+ ```lb_nat_gw``` - nat gateway

### Route tables
+ ```lb_nat_rules``` - route table for private subnets
+ ```lb_net_rules``` - route table for public subnets

### Endpoints
+ ```lb_endpoint``` - endpoint for S3

### Security groups
+ ```lb_sc``` - sc group for instances

### Net ACL
+ ```jenk_net_acl``` - rules for default net acl

### IAM role
+ ```web_read_s3_role``` - role for ec2 instances that they could read from S3

### IAM policy 
+ ```web_read_s3_policy``` - policy for IAM role

### Instances
+ ```lb_instance_1``` - first instance
+ ```lb_instance_1``` - second instance

### Targets group
+ ```lb_group``` - targets group for load balancer

### Load balancer
+ ```lb_main``` - main load balancer