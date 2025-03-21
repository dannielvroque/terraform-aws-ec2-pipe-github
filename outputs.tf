output "instance_ip" {
  description = "Endereço IP público da instância"
  value       = aws_instance.web.public_ip
}
