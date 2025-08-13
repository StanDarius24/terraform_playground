provider "aws" {
  region                      = "eu-central-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_requesting_account_id  = true

  endpoints {
    acm            = "http://127.0.0.1:4566"
    apigateway     = "http://127.0.0.1:4566"
    cloudformation = "http://127.0.0.1:4566"
    cloudwatch     = "http://127.0.0.1:4566"
    dynamodb       = "http://127.0.0.1:4566"
    ec2            = "http://127.0.0.1:4566"
    es             = "http://127.0.0.1:4566"
    events         = "http://127.0.0.1:4566"
    firehose       = "http://127.0.0.1:4566"
    iam            = "http://127.0.0.1:4566"
    kinesis        = "http://127.0.0.1:4566"
    kms            = "http://127.0.0.1:4566"
    lambda         = "http://127.0.0.1:4566"
    rds            = "http://127.0.0.1:4566"
    redshift       = "http://127.0.0.1:4566"
    route53        = "http://127.0.0.1:4566"
    s3             = "http://127.0.0.1:4566"
    secretsmanager = "http://127.0.0.1:4566"
    ses            = "http://127.0.0.1:4566"
    sns            = "http://127.0.0.1:4566"
    sqs            = "http://127.0.0.1:4566"
    ssm            = "http://127.0.0.1:4566"
    stepfunctions  = "http://127.0.0.1:4566"
    sts            = "http://127.0.0.1:4566"
    cloudwatchlogs = "http://127.0.0.1:4566"
  }
}

