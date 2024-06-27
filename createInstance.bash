#/bin/bash
TOTALGROUPS=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | wc -l`
if [ $TOTALGROUPS -eq 1 ]; then
    echo "There is $TOTALGROUPS security group"
else
    echo "There are $TOTALGROUPS security groups"
fi