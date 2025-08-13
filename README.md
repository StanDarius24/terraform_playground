HASICORP CERTIFICATION CONFIG   

===

```
docker pull localstack/localstack
```

alias aws-local='aws --endpoint-url=http://127.0.0.1:4566'

now everytime when you want to use aws-cli, use aws-local to mock responses from aws 

you might also need this config in `provider.tf`

```
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
```
