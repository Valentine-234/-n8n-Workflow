resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Project     = var.project
    Environment = var.env
    Component   = "rds"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.env}-rds-sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  # Ingress is controlled via SG rules from backend SG
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project
    Environment = var.env
    Component   = "rds"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project}-${var.env}-postgres"
  engine                  = "postgres"
  engine_version          = "17.6"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  backup_retention_period = 1
  deletion_protection     = false
  multi_az                = false
  publicly_accessible     = false
  storage_encrypted       = true

  tags               = var.tags
}