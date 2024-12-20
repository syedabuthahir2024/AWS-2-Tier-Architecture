# Public subnet EC2 instance 1
resource "aws_instance" "two-tier-web-server-1" {
  ami             = "ami-064eb0bee0c5402c5"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two-tier-ec2-sg.id]
  subnet_id       = aws_subnet.two-tier-pub-sub-1.id
  key_name        = "two-tier-key"

  tags = {
    Name = "two-tier-web-server-1"
  }

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx

# Create custom HTML content
echo "<!DOCTYPE html>
<html>
<head>
  <title>Web Server 1</title>
</head>
<body>
  <h1>Welcome to Two-Tier Architecture Web Server 1</h1>
  <p>This is a custom HTML page served by Web Server 1 in the public subnet.</p>
</body>
</html>" | sudo tee /usr/share/nginx/html/index.html
EOF
}

# Public subnet EC2 instance 2
resource "aws_instance" "two-tier-web-server-2" {
  ami             = "ami-064eb0bee0c5402c5"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two-tier-ec2-sg.id]
  subnet_id       = aws_subnet.two-tier-pub-sub-2.id
  key_name        = "two-tier-key"

  tags = {
    Name = "two-tier-web-server-2"
  }

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
sudo systemctl start nginx

# Create custom HTML content
echo "<!DOCTYPE html>
<html>
<head>
  <title>Web Server 2</title>
</head>
<body>
  <h1>Welcome to Two-Tier Architecture Web Server 2</h1>
  <p>This is a custom HTML page served by Web Server 2 in the public subnet.</p>
</body>
</html>" | sudo tee /usr/share/nginx/html/index.html
EOF
}

# EIP for EC2 instance 1
resource "aws_eip" "two-tier-web-server-1-eip" {
  vpc = true

  instance   = aws_instance.two-tier-web-server-1.id
  depends_on = [aws_internet_gateway.two-tier-igw]
}

# EIP for EC2 instance 2
resource "aws_eip" "two-tier-web-server-2-eip" {
  vpc = true

  instance   = aws_instance.two-tier-web-server-2.id
  depends_on = [aws_internet_gateway.two-tier-igw]
}
