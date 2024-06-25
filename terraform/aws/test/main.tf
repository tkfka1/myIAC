module "db_instance" {
  source  = "../modules/rds/db_instance"

  identifier        = "my-aurora-cluster"

  engine            = "aurora-mysql"
  engine_version    = "5.7.mysql_aurora.2.12.2"
  instance_class    = "db.t3.small"

  snapshot_identifier = "test-snap"  # 복원할 스냅샷 ID


  parameter_group_name = module.db_parameter_group

}