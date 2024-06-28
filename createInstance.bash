#/bin/bash

# Font: https://medium.com/@corymaklin/tutorial-amazon-web-services-part-1-create-virtual-machines-with-aws-cli-b900702bf286

TOTALGROUPS=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | wc -l`
SECURITYGROUPID=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | awk '{print $2}'`
AMIID['AMAZON']=['ami-01b799c439fd5516a','ami-0195204d5dce06d99','ami-0b8aeb1889f1a812a']

 
#   Free tier
#       In your first year includes 750 hours of t2.micro (or t3.micro in the Regions in which t2.micro is unavailable) instance usage on free tier AMIs per month, 
#       750 hours of public IPv4 address usage per month, 30 GiB of EBS storage, 2 million IOs, 1 GB of snapshots, and 100 GB of bandwidth to the internet.



AMIID=`aws ec2 describe-images --owners amazon --filters "Name=state,Values=available"  "Name=is-public,Values=true" "Name=image-type,Values=kernel" \
         --query 'Images[*].[ImageId,Name]' --output table | awk '{print $2}'`



echo "AMI ID: $AMIID"

if [ $TOTALGROUPS -eq 1 ]; then
    echo "There is $TOTALGROUPS security group"
else
    echo "There are $TOTALGROUPS security groups"
fi
echo "Security Group ID: $SECURITYGROUPID"

# At minimum, we need to open port 22 (SSH protocol) so that you can connect to your instance.

# aws ec2 authorize-security-group-ingress --group-name example --protocol tcp --port 22 --cidr 0.0.0.0/0