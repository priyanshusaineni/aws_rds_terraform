# ---- Operation ----
operation = "create"  #Switch between create and update 
create_subnet_group = false
create_security_group = false

# ---- Network ----
vpc_id              = "vpc-00c77f79f94607dbf"
subnet_ids = [
    "subnet-004aa68bfe70a7672",
    "subnet-0e09b212d51fe2268",
    "subnet-0bf8236e7a585d68c",
    "subnet-09c76d29723922c63",
    # "subnet-0c85bb6d62f36fb03",
    "subnet-01607c83fb8b03858"
  ]
subnet_group_name        = "terraform-subnet-group"
subnet_group_description = "Example subnet group for RDS"
multi_az = true

security_group_name  = "new-sg-1"

#Security group will not be created every time 
security_group_description = "Enable Postgres access"
# availability_zone = "ap-south-1a"         This is commented because rds requires multi azs requesting a specific az is not valid

ingress_from_port   = 5423
ingress_to_port     = 5432
ingress_protocol    = "tcp"
ingress_cidr_blocks = ["10.0.0.0/8"] 


# ---- Storage and Engine ----
db_instance_identifier = "new-test-db-instance"
db_instance_class = "db.t4g.large"
engine           = "postgres"
engine_version   = "17.5"
storage_type     = "gp3"
storage          = 20
copy_tags_to_snapshot     = true
delete_automated_backups  = false
skip_final_snapshot       = true

# ---- Security and Maintenance ----
deletion_protection = false 
backup_period       = 1
db_port             = 5432
maintenance_window  = "sat:22:00-sat:22:30"
publicly_accessible       = false
storage_encrypted         = true
auto_minor_version_upgrade = true

#-------User Credentials Management----------
rds_username = "db_user"
manage_master_user_password = true

# ---- Tags ----
owner       = "ARCH-Platform"
cost_center = "615110"
environment = "DEV"
name        = "new-test-db-instance"
scc_jenkins = "T"