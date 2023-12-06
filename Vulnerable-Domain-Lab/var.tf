
variable "FIRST_DC_IP" {
  default = "172.16.10.100"
}

variable "SECOND_SERVER_IP" {
  default = "172.16.10.90"
}

variable "LINUX_IP" {
  default = "172.16.10.80"
}

variable "PUBLIC_DNS" {
  default = "1.1.1.1"
}

variable "MANAGEMENT_IPS" {
  default = ["/32"]                       #add your IP here!
}

variable "DC_SUBNET_CIDR" {
    default = "172.16.10.0/24"
}

variable "My-KP" {
  default = ""                             # add your key here!
}