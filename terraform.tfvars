# ---- Network ----
vpc_id              = "vpc-00c77f79f94607dbf"
subnet_ids = [
    "subnet-004aa68bfe70a7672",
    "subnet-0e09b212d51fe2268",
    "subnet-0bf8236e7a585d68c",
    "subnet-09c76d29723922c63",
    "subnet-0c85bb6d62f36fb03",
    "subnet-01607c83fb8b03858"
  ]
subnet_group_name        = "example-subnet-group"
subnet_group_description = "Example subnet group for RDS"

kms_key_id = "arn:aws:kms:us-east-1:600802700666:key/7b0bdc95-7113-4b6c-a17b-f015a51f7c1a"
# db_subnet_group_name = 
security_group_name  = "new-sg-11"
# availability_zone = "ap-south-1a"         This is commented because rds requires multi azs requesting a specific az is not valid

# ---- Storage and Engine ----
db_instance_identifier = "new-test-db-instance"
db_instance_class = "db.t4g.large"
engine           = "postgres"
engine_version   = "17.5"
storage_type     = "gp3"
storage          = 20

# ---- Security and Maintenance ----
deletion_protection = false
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
