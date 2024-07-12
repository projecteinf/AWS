#/bin/bash

# Font: https://medium.com/@corymaklin/tutorial-amazon-web-services-part-1-create-virtual-machines-with-aws-cli-b900702bf286


 
#   Free tier
#       In your first year includes 750 hours of t2.micro (or t3.micro in the Regions in which t2.micro is unavailable) instance usage on free tier AMIs per month, 
#       750 hours of public IPv4 address usage per month, 30 GiB of EBS storage, 2 million IOs, 1 GB of snapshots, and 100 GB of bandwidth to the internet.


# Get VPC ID and Subnet ID

## Get VPC
VPC_ID=`aws ec2 describe-vpcs  --vpc-ids --query "Vpcs[*].VpcId"`
echo "VPC ID: $VPC_ID"

## Get Subnet ID
SUBNETS_ID=`aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[*].SubnetId" --output text`
echo "Subnet ID: $SUBNETS_ID"

# Get AMI ID

## Necessitem que siguin de la capa gratuita. Com que no es poden filtrar per aquesta capa, utilitzem una referència estàtica

##############################################################################################################################################################################
##                                                                                                                                                                          ##
##              aws ec2 describe-images --owners amazon --filters  "Name=is-public,Values=true"  --query 'Images[*].[ImageId,Name]' --output table                          ##
##                                                                                                                                                                          ##
##############################################################################################################################################################################

## AMI ID for free tier
AMI_ID["AMAZON"]=['ami-01b799c439fd5516a','ami-0195204d5dce06d99','ami-0b8aeb1889f1a812a'] # AMI ID for free tier

# Create a security group

TOTAL_GROUPS=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | wc -l`
echo "Total groups: $TOTAL_GROUPS"

if [ $TOTAL_GROUPS -eq 0 ]; then
    aws ec2 create-security-group --group-name default --description "Default Security Group"
    echo "Security Group created"
fi

SECURITY_GROUP_ID=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | awk '{print $2}'`
echo "Security Group ID: $SECURITY_GROUP_ID"

## Add rules to security group. Allow SSH

SSH_ENABLED=`aws ec2 describe-security-groups --group-ids $SECURITY_GROUP_ID --query "SecurityGroups[*].IpPermissions[?FromPort=='22' && ToPort=='22' && IpProtocol=='tcp'].[IpRanges,Ipv6Ranges,UserIdGroupPairs]"`
echo "SSH Enabled: $SSH_ENABLED"


if [[ ${SSH_ENABLED[*]} ]]; then
    echo "Allowing SSH"
    # aws ec2 authorize-security-group-ingress \
    #     --group-id "$SECURITY_GROUP_ID" \
    #     --protocol tcp \
    #     --port 22 \
    #     --cidr "0.0.0.0/0" 
fi

# Create SSH Key Pair

