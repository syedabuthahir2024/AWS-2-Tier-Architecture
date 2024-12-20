Two-Tier Architecture on AWS using Terraform :

This project demonstrates the creation of a Two-Tier Architecture on AWS using Terraform. The architecture includes a public-facing application layer hosted on EC2 instances behind an Application Load Balancer and a private database tier using an RDS MySQL instance. The infrastructure is provisioned in the `ap-southeast-1` AWS region.

Project Overview :

The two-tier architecture includes a VPC with a CIDR block of `10.0.0.0/16`, public subnets for the application tier, private subnets for the database tier, and an Internet Gateway with associated route tables for public internet access. The application layer consists of two EC2 instances running Amazon Linux 2 AMI and NGINX, distributed via an Application Load Balancer. The database layer features an RDS MySQL instance deployed in private subnets, with database subnet group and security group configurations. Security is enforced with tailored security groups allowing HTTP, HTTPS, and SSH access to the application tier.

Project Structure :

This project includes the following Terraform configuration files:
- `provider.tf` to configure the AWS provider and region.
- `network.tf` to set up the VPC, subnets, Internet Gateway, and route tables.
- `ec2.tf` to provision EC2 instances, Elastic IPs, and the Load Balancer.
- `security.tf` to define security groups for EC2, the Load Balancer, and RDS.
- `database.tf` to configure the RDS MySQL instance and associated subnet group.

Why do We use Two-Tier Architecture?

There are several reasons why AWS two-tier architecture is a popular choice for deploying web applications in the cloud:
1. The two-tier architecture is designed to enable independent scalability for each tier. For instance, if the web server tier experiences increased traffic demand, additional web server instances can be provisioned, with the load balancer efficiently distributing incoming requests. Similarly, the database tier can scale by incorporating additional storage or deploying more database instances to accommodate growing data requirements.
2. The two-tier architecture is built with fault tolerance in mind, incorporating multiple web server and database instances to ensure redundancy. In the event of a server or instance failure, the load balancer seamlessly redirects traffic to the remaining operational instances, ensuring continuous application availability.
3. The separation of the web server and database tiers enhances security by isolating the database from direct internet access. This is achieved through the use of firewalls or security groups, which enforce strict access controls, allowing only authorized sources, such as the web server tier, to communicate with the database.
