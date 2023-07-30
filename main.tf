resource "aws_key_pair" "public_key" {
  key_name = "app-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "elk-app-instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  key_name = "app-key"
  vpc_security_group_ids = [aws_security_group.allow_elk.id]

   tags = {
    Name = "elk-instance"
  }

  connection {
    type = "ssh"
    host = aws_instance.elk-app-instance.public_ip
    user = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
  
   provisioner "file" {
    source      = "./kibana.yml"
    destination = "/tmp/kibana.yml"
  }

  provisioner "file" {
    source      = "./installELK.sh"
    destination = "/tmp/installELK.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installELK.sh",
      "sudo /tmp/installELK.sh"
    ]
  }
}
