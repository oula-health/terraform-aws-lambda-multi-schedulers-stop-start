data "aws_region" "current" {}

module "scheduler" {
  for_each = var.schedulers
  #source   = "diodonfrost/lambda-scheduler-stop-start/aws"
  source   = var.module_source
  #version  = "4.2.0"
  version  = var.module_version

  name                            = each.value.name
  schedule_expression             = each.value.schedule_expression
  schedule_expression_timezone    = each.value.schedule_expression_timezone
  scheduler_excluded_dates        = each.value.scheduler_excluded_dates
  custom_iam_role_arn             = each.value.custom_iam_role_arn
  kms_key_arn                     = each.value.kms_key_arn
  aws_regions                     = each.value.aws_regions == null ? [data.aws_region.current.name] : each.value.aws_regions
  runtime                         = each.value.runtime
  schedule_action                 = each.value.schedule_action
  resources_tag                   = each.value.resources_tag
  scheduler_tag                   = each.value.scheduler_tag
  autoscaling_schedule            = each.value.autoscaling_schedule
  autoscaling_terminate_instances = each.value.autoscaling_terminate_instances
  ec2_schedule                    = each.value.ec2_schedule
  documentdb_schedule             = each.value.documentdb_schedule
  ecs_schedule                    = each.value.ecs_schedule
  scheduler_schedule              = each.value.scheduler_schedule
  scheduler_schedule_names        = each.value.scheduler_schedule_names
  elasticache_valkey_schedule     = each.value.elasticache_valkey_schedule
  elasticache_valkey_replication_groups_to_delete     = each.value.elasticache_valkey_replication_groups_to_delete
  elasticache_valkey_replication_groups_to_create     = each.value.elasticache_valkey_replication_groups_to_create
  rds_schedule                    = each.value.rds_schedule
  redshift_schedule               = each.value.redshift_schedule
  cloudwatch_alarm_schedule       = each.value.cloudwatch_alarm_schedule
  transfer_schedule               = each.value.transfer_schedule
  tags                            = each.value.tags
}
