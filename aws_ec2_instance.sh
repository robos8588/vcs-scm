#!/bin/bash

# AWS Region where you want to launch the EC2 instance
REGION="us-east-1"

# EC2 instance details
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-12345678"  # Replace with your desired AMI ID
KEY_NAME="your-key-name"  # Replace with your EC2 key pair name
SECURITY_GROUP_IDS="sg-0123456789abcdef0"  # Replace with your security group IDs
SUBNET_ID="subnet-0123456789abcdef0"  # Replace with your subnet ID
INSTANCE_NAME="MyEC2Instance"  # Replace with your desired instance name

# Launch the EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
  --region $REGION \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_IDS \
  --subnet-id $SUBNET_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --output json | jq -r '.Instances[0].InstanceId')

# Wait for the instance to be running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Get the public DNS name of the instance
PUBLIC_DNS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --region $REGION --query 'Reservations[0].Instances[0].PublicDnsName' --output text)

echo "EC2 instance $INSTANCE_ID is now running with Public DNS: $PUBLIC_DNS"
