# What region do you need work?
# Remember change region, maybe your AMI ID can change too.
variable "region" {
  default     = "us-east-1"
  description = "Regiao"
}
# Choose your AMI
# ATENTION! But remember this Amazon Image need listening port 80
# Without this your AutoScaling will broken and create many instances :/
variable "ami" {
  #default     = "ami-0ac80df6eff0e70b5" # Ubuntu Server 18.04 LTS
  description = "Set some AMI, remember this AMI need listen something port 80"
}
# What family do you need?
# You can create a dev.tfvar to replace this values
variable "family" {
  default     = "t2.micro"
  description = "Familia escolhida elegivel a FreeTier"
}
# What key_ssh do you want use?
variable "key_ssh" {
  default     = "default-key-tonnytg"
  description = "Choose your default key to access this machines"
}
