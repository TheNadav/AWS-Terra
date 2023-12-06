data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220606.1-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}
resource "aws_instance" "app-server" {
  count                  = length(var.subnet_cidr_public)
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.amazon_ami.id
  vpc_security_group_ids = [aws_security_group.ec2_instance.id]
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  associate_public_ip_address = true
  tags = {
    Name = "app-server-${count.index + 1}"
  }
  user_data = file("user_data/user_data.tpl")
}