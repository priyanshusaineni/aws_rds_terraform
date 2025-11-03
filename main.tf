# ---- Data Sources to Retrieve Existing Resources ----

data "aws_vpc" "selected" {
  id = var.vpc_id
}
  
data "aws_db_subnet_group" "selected" {
  name = var.subnet_group_name
}

resource "aws_db_subnet_group" "example" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  description = var.subnet_group_description
  tags = {
    SCC_Jenkins = "T"
    Owner       = var.owner
    CostCenter  = var.cost_center
    Environment = var.environment
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }
  vpc_id = data.aws_vpc.selected.id
}

# If master credentials are stored in Secrets Manager as string key:value pairs

# ---- 1st approach where we are assigning the master user credentials through already existing username and password from aws secrets manager
# data "aws_secretsmanager_secret_version" "db_admin_user" {
#   secret_id = "rds-secrets"
# }
# data "aws_secretsmanager_secret_version" "db_admin_password" {
#   secret_id = "rds-secrets"
# }
# locals {
#   db_admin     = jsondecode(data.aws_secretsmanager_secret_version.db_admin_user.secret_string)["new-test-db-instance-admin-user"]
#   db_admin_pass = jsondecode(data.aws_secretsmanager_secret_version.db_admin_password.secret_string)["new-test-db-instance-admin-password"]
# }

# ---- RDS Security Group ----
resource "aws_security_group" "scc_postgres_dbsg" {
  name        = var.security_group_name
  description = "Enable PostgreSQL access"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 5423
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]  # Adjust per your requirements
  }

  tags = {
    SCC_Jenkins = "T"
    Owner       = var.owner
    CostCenter  = var.cost_center
    Environment = var.environment
  }
}

# ---- RDS Instance ----  
resource "aws_db_instance" "test_db" {
  allocated_storage         = var.storage
  storage_type              = var.storage_type
  # availability_zone         = var.availability_zone
  backup_retention_period   = var.backup_period
  instance_class            = var.db_instance_class
  identifier                = var.db_instance_identifier
  db_subnet_group_name      = var.operation == "create" ? aws_db_subnet_group.example.name : data.aws_db_subnet_group.selected.name                           # = data.aws_db_subnet_group.selected.name           Use If you are reading it with data block
  deletion_protection       = var.deletion_protection
  engine                    = var.engine
  engine_version            = var.engine_version

  # 1st approach
  # username                  = local.db_admin_user
  # password                  = local.db_admin_pass

  #standard approach
  username = var.rds_username  
  manage_master_user_password = true

  port                      = var.db_port
  maintenance_window        = var.maintenance_window
  publicly_accessible       = false
  storage_encrypted         = true
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot     = true
  delete_automated_backups  = false
  vpc_security_group_ids    = var.operation == "create" ? [aws_security_group.scc_postgres_dbsg.id] : [data.aws_security_group.selected.id]
  skip_final_snapshot       = true
  multi_az = true

  kms_key_id = var.kms_key_id
  tags = {
    # SCC_Jenkins = "T"
    Name        = var.name
    Owner       = var.owner
    CostCenter  = var.cost_center
    Environment = var.environment
  }
}
