
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