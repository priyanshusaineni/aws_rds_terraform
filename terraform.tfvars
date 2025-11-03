# ---- Network ----
vpc_id              = "vpc-00c77f79f94607dbf"
db_subnet_group_name = "default"
security_group_name  = "new-sg-1"
# availability_zone = "ap-south-1a"         This is commented because rds requires multi azs requesting a specific az is not valid

# ---- Storage and Engine ----
db_instance_identifier = "new-test-db-instance"
db_instance_class = "db.t4g.large"
engine           = "postgres"
engine_version   = "17.5"
storage_type     = "gp3"
storage          = 20

# ---- Security and Maintenance ----
deletion_protection = true
backup_period       = 1
db_port             = 5432
maintenance_window  = "sat:22:00-sat:22:30"

#-------User Credentials-----------
rds_username = "db_user"

# ---- Tags ----
owner       = "ARCH-Platform"
cost_center = "615110"
environment = "DEV"
name        = "new-test-db-instance"
