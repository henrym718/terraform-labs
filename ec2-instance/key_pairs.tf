# #Establesco el algoritmo de encryption para craae la llave privada
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
}

#Creo la llave publica para la instancia ec2.
variable "key_rsa" {}
resource "aws_key_pair" "key_pair" {  
  key_name = var.key_rsa
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

#Descargo la llave privada al sistema local
resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_rsa
}
