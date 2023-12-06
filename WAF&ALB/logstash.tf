#Logstash Security Group ----------------------

resource "aws_security_group" "logstash_sg" {
  ingress {
    description = "ingress rules"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
  egress {
    description = "egress rules"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
  tags={
    Name="logstash_sg"
  }
}

#Logstash Server --------------------------------------------

resource "aws_instance" "logstash" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "m4.large"
  vpc_security_group_ids = [aws_security_group.logstash_sg.id]
  key_name               = "My-KP"                                          #Change!!!!
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.logstash_profile.name

  root_block_device {
      volume_size = 50
      volume_type = "gp3"
      encrypted = true
    }
  tags = {
    Name = "logstash"
  }
  user_data = file("user_data/logstash_data.tpl")
}

#Logstash Role ------------------------------------------------

resource "aws_iam_role" "logstash_role" {
  name = "logstash_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "logstash_profile" {
  name = "logstash_profile"
  role = aws_iam_role.logstash_role.name
}

resource "aws_iam_role_policy" "logstash_s3_policy" {
  name = "logstash_s3_policy"
  role = aws_iam_role.logstash_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}