
provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}

# DC 01------
resource "aws_instance" "DC-01" {
    ami = "ami-0cd601a22ac9e6d79"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.DC-Subnet.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.first-sg.id]
    private_ip = var.FIRST_DC_IP
    key_name = var.My-KP 

    root_block_device {
      volume_size = 50
      volume_type = "gp3"
      encrypted = true
    }

    tags = {
      Name = "DC-01"
    }
}

# DC 02 ------
resource "aws_instance" "Server-02" {
    ami = "ami-0cd601a22ac9e6d79"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.DC-Subnet.id
    associate_public_ip_address = true
    private_ip = var.SECOND_SERVER_IP
    key_name = var.My-KP
    vpc_security_group_ids = [ aws_security_group.first-sg.id]

    root_block_device {
      volume_size = 50
      volume_type = "gp3"
      encrypted = true
    }
    
    tags = {
      Name = "Server-02"
    }
}

# Linux 01 ------
resource "aws_instance" "Linux" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.DC-Subnet.id
    associate_public_ip_address = true
    private_ip = var.LINUX_IP
    key_name = var.My-KP
    vpc_security_group_ids = [ aws_security_group.first-sg.id]

    root_block_device {
      volume_size = 50
      volume_type = "gp3"
      encrypted = true
    }
    
    tags = {
      Name = "Linux"
    }
}


# Main VPC ------
resource "aws_vpc" "Main-VPC" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Main-VPC"
  }
}


# DC Subnet ------
resource "aws_subnet" "DC-Subnet" {
  vpc_id            = aws_vpc.Main-VPC.id
  cidr_block        = var.DC_SUBNET_CIDR
  availability_zone = "us-east-1a"

  tags = {
    Name = "DC-Subnet"
  }
}


# Set DHCP options for delivering things like DNS servers
resource "aws_vpc_dhcp_options" "first-dhcp" {
  domain_name          = "NADAV.local"
  domain_name_servers  = [var.FIRST_DC_IP, var.PUBLIC_DNS]
  ntp_servers          = [var.FIRST_DC_IP]
  netbios_name_servers = [var.FIRST_DC_IP]
  netbios_node_type    = 2

  tags = {
    Name = "First-DHCP"
  }
}
# Associate our DHCP configuration with our VPC
resource "aws_vpc_dhcp_options_association" "first-dhcp-assoc" {
  vpc_id          = aws_vpc.Main-VPC.id
  dhcp_options_id = aws_vpc_dhcp_options.first-dhcp.id
}


# Security group for first.local
resource "aws_security_group" "first-sg" {
  vpc_id = aws_vpc.Main-VPC.id
  ingress {
    protocol    = "-1"
    cidr_blocks = [var.DC_SUBNET_CIDR]
    from_port   = 0
    to_port     = 0
  }
  # Allow management from our IP
  ingress {
    protocol    = "-1"
    cidr_blocks = var.MANAGEMENT_IPS
    from_port   = 0
    to_port     = 0
  }
    # Allow global outbound
  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}


# Default route required for the VPC to push traffic via gateway
resource "aws_route" "first-internet-route" {
  route_table_id         = aws_vpc.Main-VPC.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab-vpc-gateway.id
}

# Gateway which allows outbound and inbound internet access to the VPC
resource "aws_internet_gateway" "lab-vpc-gateway" {
  vpc_id = aws_vpc.Main-VPC.id
}