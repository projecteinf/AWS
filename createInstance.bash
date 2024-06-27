#/bin/bash
TOTALGROUPS=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | wc -l`
SECURITYGROUPID=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | awk '{print $2}'`
AMIID=`aws ec2 describe-images --owners self --query 'Images[*].[ImageId,Name]' --output table | grep "Ubuntu" | awk '{print $2}'`

echo "AMI ID: $AMIID"

if [ $TOTALGROUPS -eq 1 ]; then
    echo "There is $TOTALGROUPS security group"
else
    echo "There are $TOTALGROUPS security groups"
fi
echo "Security Group ID: $SECURITYGROUPID"