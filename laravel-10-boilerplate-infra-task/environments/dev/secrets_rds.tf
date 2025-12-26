resource "aws_secretsmanager_secret" "rds" {
  name = "${var.project}/${var.env}/rds"

  description = "RDS credentials for ${var.project} ${var.env}"

  recovery_window_in_days = 7

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-rds-secret" }
  )
}

resource "random_password" "rds" {
  length  = 32
  special = true
}

resource "aws_secretsmanager_secret_version" "rds" {
  secret_id = aws_secretsmanager_secret.rds.id

  secret_string = jsonencode({
    db_name  = var.db_name
    username = var.db_username
    password = random_password.rds.result
  })
}

data "aws_secretsmanager_secret_version" "rds" {
  secret_id = aws_secretsmanager_secret.rds.id

  depends_on = [
    aws_secretsmanager_secret_version.rds
  ]
}

locals {
  rds_secret = jsondecode(
    data.aws_secretsmanager_secret_version.rds.secret_string
  )
}
