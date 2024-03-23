resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "fiap-rds-mysql-instance" {
  engine                 = "mysql"
  identifier             = "fiap-hackathon-db"
  allocated_storage      = 20
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true
}

resource "null_resource" "db_init" {
  depends_on = [aws_db_instance.fiap-rds-mysql-instance]

  provisioner "local-exec" {
    command = "mysql -h ${replace(aws_db_instance.fiap-rds-mysql-instance.endpoint, ":3306", "")} -P 3306 -u ${var.db_username} -p${var.db_password} < ./modules/rds/start-db.sql"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.fiap-rds-mysql-instance.endpoint
}
