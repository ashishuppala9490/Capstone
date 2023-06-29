provider "aws" {
  region = "us-east-1"
}

resource "aws_iot_topic_rule" "iot-topic-rule" {
  name    = "iot-topic-rule"
  topic   = "my-topic"
  enabled = true

  aws_iot_sql_version = "2016-03-23"

  sql = <<SQL
    SELECT * FROM 'my-topic'
SQL
}