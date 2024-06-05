
#Crear el grupo de seguridad de la instancia de aws
resource "aws_security_group" "security_group_ec2" {
  name = "security_group_ec2"  
      
  ingress {    
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    
  }

  ingress {    
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
