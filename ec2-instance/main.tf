#Establecer el provedor de nube en el que se va a desplegar
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

#Proporcionar las credenciales de acceso al recurso del proveedor
provider "aws" {
  region = "sa-east-1"
  access_key = "access_key"
  secret_key = "secret_key"    
}

#Crear el grupo de seguridad de la instancia de aws
resource "aws_security_group" "security_group_ec2" {
  name = "security_group_ec2"
  description = "Security group for SSH and HTTP"
    
  ingress {
    description = "Allowed All to ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allowed All to http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Establesco el algoritmo de encryption para craae la llave privada
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
}

#Creo la llave publica para la instancia ec2
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

#Levantar la instancia con los parametros necesarios
resource "aws_instance" "ec2fromterraform" {
   ami =  "ami-0cdc2f24b2f67ea17"
   instance_type = "t2.micro"
   security_groups = [aws_security_group.security_group_ec2.name]
   key_name = aws_key_pair.key_pair.key_name
   tags = {
    Name: "aws_instance"
    }
    #user_data = Puedo ingresar algun script de ejecucion
}