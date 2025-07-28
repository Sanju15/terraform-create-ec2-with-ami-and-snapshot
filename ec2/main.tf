data "aws_ami" "ami_backup" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "image-id"
    values = ["ami-a1b2c3d4e5f6g7"] # AMI id here
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.name_prefix}-sg"
  description = "Allow ports"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    security_groups = [var.security_group_id]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ami_backup.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = false

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ec2-${var.environment}"
  })

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/sdf" 
    snapshot_id           = "snap-1231231234" # Snapshot id here
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = false
  }

}