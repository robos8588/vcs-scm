# AWS Region where you want to launch the EC2 instance
$region = "us-east-1"

# EC2 instance details
$instanceType = "t2.micro"
$amiId = "ami-12345678"  # Replace with your desired AMI ID
$keyName = "your-key-name"  # Replace with your EC2 key pair name
$securityGroupIds = "sg-0123456789abcdef0"  # Replace with your security group IDs
$subnetId = "subnet-0123456789abcdef0"  # Replace with your subnet ID
$instanceName = "MyEC2Instance"  # Replace with your desired instance name

# Launch the EC2 instance
$instance = New-EC2Instance -ImageId $amiId -InstanceType $instanceType -KeyName $keyName -SecurityGroupId $securityGroupIds -SubnetId $subnetId -Region $region

# Tag the instance with a Name tag
Add-EC2ResourceTag -ResourceId $instance.Instances.InstanceId -Tag @{ Key = "Name"; Value = $instanceName } -Region $region

# Wait for the instance to be running
Write-Host "Waiting for the instance to be in the running state..."
$runningInstance = Wait-EC2Instance -InstanceId $instance.Instances.InstanceId -Region $region

# Get the public DNS name of the instance
$publicDns = $runningInstance.Instances[0].PublicDnsName

Write-Host "EC2 instance $($runningInstance.Instances[0].InstanceId) is now running with Public DNS: $publicDns"
