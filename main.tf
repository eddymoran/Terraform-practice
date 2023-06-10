#configuration language for main file


#Begin resource blocks

# Configure EC2 instance
resource "aws_instance" "week20instance" {
  ami                    = var.ami
  instance_type          = var.instance
  user_data              = var.ec2_user_data
  vpc_security_group_ids = [aws_security_group.week20_sg.id]
  key_name               = "Week20Jenkins"
  tags = {
    Name = "Week 20 Jenkins Instance"
  }
}

# Configure security group
resource "aws_security_group" "week20_sg" {
  name        = "week20_sg"
  description = "Security group for week 20"


  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Week 20 security group"
  }
}

#Create random ID for S3 bucket
resource "random_id" "randomness" {
  byte_length = 16
}


#Configure s3 bucket
resource "aws_s3_bucket" "jenkins-s3-bucket" {
  bucket = "jenkins-artifacts-10534"
  acl    = "private"

  tags = {
    Name = "Jenkins bucket"
  }
}

#End resource blocks