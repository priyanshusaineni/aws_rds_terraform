# ---- Data Sources to Retrieve Existing Resources ----

data "aws_vpc" "selected" {
  id = var.vpc_id
}
# data "aws_db_subnet_group" "selected" {
#   count = var.create_subnet_group ? 0 : 1
#   name = var.subnet_group_name
# }
data "aws_kms_key" "example" {
  key_id = "alias/custom_kms"  
}

resource "aws_db_subnet_group" "example" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  description = var.subnet_group_description
  tags = {
    SCC_Jenkins = var.scc_jenkins
    Owner       = var.owner
    CostCenter  = var.cost_center
    Environment = var.environment
  }
}

data "aws_security_group" "selected" {
  count = var.create_security_group ? 0 : 1 
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
# resource "aws_security_group" "scc_postgres_dbsg" {
#   name        = var.security_group_name
#   description = var.security_group_description
#   vpc_id      = data.aws_vpc.selected.id

#   ingress {
#     from_port   = var.ingress_from_port
#     to_port     = var.ingress_to_port
#     protocol    = var.ingress_protocol
#     cidr_blocks = var.ingress_cidr_blocks  
#   }

#   tags = {
#     SCC_Jenkins = var.scc_jenkins
#     Owner       = var.owner
#     CostCenter  = var.cost_center
#     Environment = var.environment
#   }
# }

# ---- RDS Instance ----  
resource "aws_db_instance" "test_db" {
  allocated_storage         = var.storage
  storage_type              = var.storage_type
  # availability_zone         = var.availability_zone
  backup_retention_period   = var.backup_period
  instance_class            = var.db_instance_class
  identifier                = var.db_instance_identifier
  # db_subnet_group_name      = var.operation == "create" ?  aws_db_subnet_group.example.name : data.aws_db_subnet_group.selected.name                           # = data.aws_db_subnet_group.selected.name           Use If you are reading it with data block
  
  db_subnet_group_name = aws_db_subnet_group.example.name
  engine                    = var.engine
  engine_version            = var.engine_version

  # 1st approach
  # username                  = local.db_admin_user
  # password                  = local.db_admin_pass

  #standard approach
  username = var.rds_username  
  manage_master_user_password = var.manage_master_user_password

  port                      = var.db_port
  maintenance_window        = var.maintenance_window
  publicly_accessible       = var.publicly_accessible
  storage_encrypted         = var.storage_encrypted
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  delete_automated_backups  = var.delete_automated_backups
  # vpc_security_group_ids    = var.operation == "create" ? [aws_security_group.scc_postgres_dbsg.id] : [data.aws_security_group.selected.id]
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  skip_final_snapshot       = var.skip_final_snapshot
  multi_az = var.multi_az

  kms_key_id = data.aws_kms_key.example.arn
  tags = {
    SCC_Jenkins = var.scc_jenkins
    Name        = var.name
    Owner       = var.owner
    CostCenter  = var.cost_center
    Environment = var.environment
  }
}
