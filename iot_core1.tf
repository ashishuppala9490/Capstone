# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # Replace with your desired AWS region
}

# Create an IoT Core thing
resource "aws_iot_thing" "my_thing" {
  name = "my-thing"  # Replace with your desired thing name
}

# Create an IoT Core thing type
resource "aws_iot_thing_type" "my_thing_type" {
  name = "my-thing-type"  # Replace with your desired thing type name
}

# Create a certificate for the thing
resource "aws_iot_certificate" "my_certificate" {
  active = true
}

# Attach the certificate to the thing
resource "aws_iot_thing_principal_attachment" "my_attachment" {
  thing_name      = aws_iot_thing.my_thing.name
  principal       = aws_iot_certificate.my_certificate.arn
  attachment_type = "cert"
}

# Create an IoT Core policy
resource "aws_iot_policy" "my_policy" {
  name        = "my-policy"  # Replace with your desired policy name
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish",
        "iot:Subscribe",
        "iot:Connect",
        "iot:Receive"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# Attach the policy to the certificate
resource "aws_iot_policy_attachment" "my_policy_attachment" {
  policy_name = aws_iot_policy.my_policy.name
  target      = aws_iot_certificate.my_certificate.arn
}

# Create an IoT Core rule
resource "aws_iot_topic_rule" "my_rule" {
  name        = "my-rule"  # Replace with your desired rule name
  description = "My IoT Core rule"
  sql         = "SELECT * FROM 'my-topic'"
  action {
    lambda {
      function_arn = "arn:aws:lambda:us-west-2:123456789012:function:my-lambda-function"  # Replace with your Lambda function ARN
    }
  }
  rule_disabled = false
}
Make sure to replace the placeholder values with your desired names, region, and specific resource ARNs. Additionally, you may need to configure your AWS credentials before running the Terraform script.

This script creates an AWS IoT Core "thing" and a thing type. It also generates a certificate for the thing, attaches the certificate to the thing, creates an IoT Core policy, attaches the policy to the certificate, and creates an IoT Core rule that triggers a Lambda function when a message is received on a specific topic.

Feel free to modify the script according to your specific requirements and resources. Remember to initialize Terraform in the working directory (terraform init) and then apply the changes (terraform apply) to provision the infrastructure.






