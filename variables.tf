variable "module_source" {
  description = "A source of module"
  type        = string
  default     = "diodonfrost/lambda-scheduler-stop-start/aws"
}

variable "module_version" {
  description = "Version of module to use"
  type        = string
  default     = "4.2.0"
}

variable "schedulers" {
  description = "A map of scheduler configurations"
  type = map(object({
    name                         = string
    schedule_expression          = optional(string, null)
    schedule_expression_timezone = optional(string, "UTC")
    scheduler_excluded_dates     = optional(list(string), [])
    custom_iam_role_arn          = optional(string, null)
    kms_key_arn                  = optional(string, null)
    aws_regions                  = optional(list(string), null)
    runtime                      = optional(string, "python3.13")
    schedule_action              = optional(string, "stop")
    resources_tag                = optional(map(string), null)
    scheduler_tag = optional(map(string), {
      "key"   = "tostop"
      "value" = "true"
    })
    autoscaling_schedule            = optional(bool, false)
    autoscaling_terminate_instances = optional(bool, false)
    ec2_schedule                    = optional(bool, false)
    documentdb_schedule             = optional(bool, false)
    ecs_schedule                    = optional(bool, false)
    scheduler_schedule              = optional(bool, false)
    scheduler_schedule_names        = optional(list(string), [])
    elasticache_valkey_schedule     = optional(bool, false)
    elasticache_valkey_replication_groups_to_delete = optional(list(string), [])
    elasticache_valkey_replication_groups_to_create = optional(
      list(object({
      # Required strings
      ReplicationGroupId          = string
      ReplicationGroupDescription = string
      CacheNodeType               = string
      Engine                      = string
      EngineVersion               = string
      CacheParameterGroupName     = string
      CacheSubnetGroupName        = string
      NetworkType                 = string
      ClusterMode                 = string

      # Optional booleans
      AutomaticFailoverEnabled    = optional(bool)
      MultiAZEnabled              = optional(bool)
      TransitEncryptionEnabled    = optional(bool)
      AtRestEncryptionEnabled     = optional(bool)
      AutoMinorVersionUpgrade     = optional(bool)

      # Optional integers
      SnapshotRetentionLimit      = optional(number)
      ReplicasPerNodeGroup        = optional(number)

      # Optional strings
      SnapshotWindow              = optional(string)
      AuthToken                   = optional(string)

      # Optional lists
      SecurityGroupIds            = optional(list(string))

      # Optional nested list-of-objects
      LogDeliveryConfigurations   = optional(list(object({
        LogType         = string
        DestinationType = string
        LogFormat       = optional(string)
        DestinationDetails = object({
          CloudWatchLogsDetails = object({
            LogGroup = string
          })
        })
      })))

      # Optional tags
      Tags = optional(map(string))
      }))
      ,[]
    )
    elb_schedule     = optional(bool, false)
    elb_to_delete = optional(list(string), [])
    elb_to_create = optional(
      list(object({
        # Required strings
        Name          = string
        Subnets               = list(string)
        SecurityGroups                      = list(string)

        Attributes = optional(list(map(string)))
        OldAlarmPattern = optional(string)

      Listeners         = optional(list(object({
        Protocol = string
        Port = string
        SslPolicy = optional(string)
        Certificates = optional(list(object({
          CertificateArn = optional(string)
          IsDefault = optional(string)
        })))
        DefaultActions = list(object({
          Type = string
          RedirectConfig = optional(object({
            Protocol = optional(string)
            Host = optional(string)
            Path = optional(string)
            Port = optional(string)
            Query = optional(string)
            StatusCode = optional(string)
          }))
          FixedResponseConfig = optional(object({
            MessageBody = optional(string)
            StatusCode = optional(string)
            ContentType = optional(string)
          }))
        }))
        Rules = optional(list(object({
          Priority = string
          Conditions = list(object({
            Field = string
            Values = optional(list(string))
            SourceIpConfig = optional(object({Values = list(string)}))
          }))
          Actions = list(object({
            Type = string
            TargetGroupArn = string
          }))
          Tags = optional(list(map(string)))
        })))
        Tags = optional(list(map(string)))
        })))

        Route53Domains = optional(list(object({
          HostedZoneId = string
          DomainName = string
          RecordType = string
     })))


     # Optional tags
     Tags = optional(map(string))
    }))
    )

    rds_schedule                    = optional(bool, false)
    redshift_schedule               = optional(bool, false)
    cloudwatch_alarm_schedule       = optional(bool, false)
    transfer_schedule               = optional(bool, false)
    tags                            = optional(map(any), null)
  }))

  default = {}
}
