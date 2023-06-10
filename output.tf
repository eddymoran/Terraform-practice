#Configure =output
output "public_ip" {
  value       = aws_instance.week20instance.public_ip
  description = "Public IP address for Jenkins server"
}