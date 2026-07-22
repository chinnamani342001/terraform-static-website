output "instance_id" {

  value = aws_instance.webserver.id

}

output "public_ip" {

  value = aws_instance.webserver.public_ip

}

output "website_url" {

  value = "http://${aws_instance.webserver.public_ip}"

}
