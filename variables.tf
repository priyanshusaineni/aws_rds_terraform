# ---- VPC and Network ----
variable "vpc_id" {
  description = "The ID of the existing VPC where RDS will be deployed"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Existing DB Subnet Group Name"
  type        = string
}

variable "security_group_name" {
  description = "Name of the RDS security group"
  type        = string
}

# ---- RDS Instance Parameters ----
variable "storage" {
  description = "Storage (in GB) allocated for the RDS instance"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type (gp2, gp3, io1, or standard)"
  type        = string
  default     = "gp2"
}

variable "availability_zone" {
  description = "Availability zone to deploy the instance"
  type        = string
  default     = "us-east-1a"
}

variable "engine" {
  description = "Database engine type (e.g., postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "14.1"
}

variable "db_instance_class" {
  description = "Type of DB instance (e.g., db.t3.micro, db.t4g.xlarge)"
  type        = string
  default     = "db.t4g.xlarge"
}

variable "db_instance_identifier" {
  description = "Identifier name for the RDS instance"
  type        = string
  default     = "new-test-db-instance"
}

variable "deletion_protection" {
  description = "Enables or disables deletion protection"
  type        = bool
  default     = false
}

variable "backup_period" {
  description = "Backup retention period (in days)"
  type        = number
  default     = 1
}

variable "db_port" {
  description = "Port number on which the DB listens"
  type        = number
  default     = 5432
}

variable "maintenance_window" {
  description = "Preferred maintenance window in ddd:hh24:mi-ddd:hh24:mi format"
  type        = string
  default     = "sat:22:00-sat:22:30"
}

# ---- Admin Credentials ----
# variable "db_admin" {
#   description = "Database master username (fetched via Secrets Manager)"
#   type        = string
#   sensitive   = true
#   default     = "{{resolve:secretsmanager:rds-secrets:SecretString:new-test-db-instance-admin-user}}"
# }

# variable "db_admin_pass" {
#   description = "Database master password (fetched via Secrets Manager)"
#   type        = string
#   sensitive   = true
#   default     = "{{resolve:secretsmanager:rds-secrets:SecretString:new-test-db-instance-admin-password}}"
# }


variable "rds_username" {
  description = "Name of the RDS Username"
  type        = string
}

# ---- Tags ----
variable "owner" {
  description = "Tag: Owner name"
  type        = string
  default     = "Arch-Ops"
}

variable "cost_center" {
  description = "Tag: Cost center value"
  type        = string
  default     = "615114"
}

variable "environment" {
  description = "Tag: Environment value (e.g. DEV, QA, PROD)"
  type        = string
  default     = "DEV"
}

variable "name" {
  description = "Tag: Name for RDS instance"
  type        = string
  default     = "new-test-db-instance"
}
