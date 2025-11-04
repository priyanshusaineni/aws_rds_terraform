variable "create_subnet_group" {
  description = "To verify subnet group needs to be created"
  type = bool
}

variable "create_security_group" {
  description = "To verify security group needs to be created"
  type = bool
}

# ---- VPC and Network ----
variable "vpc_id" {
  description = "The ID of the existing VPC where RDS will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Name of the RDS subnet group"
  type        = string
  default     = "example-subnet-group"
}

variable "subnet_group_description" {
  description = "Description of the RDS subnet group"
  type        = string
  default     = "Example subnet group for RDS"
}

# variable "db_subnet_group_name" {
#   description = "Existing DB Subnet Group Name"
#   type        = string
# }

variable "security_group_name" {
  description = "Name of the RDS security group"
  type        = string
}

variable "security_group_description" {
  description = "Description of the Security Group"
  type = string
}

variable "ingress_from_port" {
  description = "The starting port for the ingress rule"
  type        = number
}

variable "ingress_to_port" {
  description = "The ending port for the ingress rule"
  type        = number
}

variable "ingress_protocol" {
  description = "The protocol for the ingress rule (e.g., tcp, udp)"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow ingress from"
  type        = list(string)
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

variable "kms_key_id" {
  description = "KMS key id"
  type        = string
  default     = ""
}

variable "operation" {
  description = "Operation being performed on the databases"
  type        = string
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

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot"
  type        = bool
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
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

variable "manage_master_user_password" {
  description = "Enables or Disables managing master user credentials within AWS"
  type = string
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

variable "scc_jenkins" {
  description = "Tag: SCC Jenkins" 
  type = string
}