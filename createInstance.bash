#/bin/bash

# NO HI HA UNA FORMA CLARA DE VEURE LES IMATGES QUE NO SÓN FREE-TIER
# Obtenir la informació de les dades d'una imatge que no és free-trie

NOFREETIER=`aws ec2 describe-images --filters "Name=image-id,Values=ami-0301be0087bfbe7c8" --owners amazon --query "Images[*]" --output table`

FREETIER=`aws ec2 describe-images --filters "Name=image-id,Values=ami-01b799c439fd5516a" --owners amazon --query "Images[*]" --output table`

echo "No Free Tier: $NOFREETIER"
echo -e "\n\n**********************************************************************************************************************************\n\n"
echo "Free Tier: $FREETIER"


# ********************************************************************************************************************


TOTALGROUPS=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | wc -l`
SECURITYGROUPID=`aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupId,GroupName,Description]" --output table | grep default | grep sg- | awk '{print $2}'`








AMIID=`aws ec2 describe-images --owners amazon --filters "Name=state,Values=available"  "Name=is-public,Values=true" "Name=image-type,Values=kernel" \
         --query 'Images[*].[ImageId,Name]' --output table | awk '{print $2}'`



echo "AMI ID: $AMIID"

if [ $TOTALGROUPS -eq 1 ]; then
    echo "There is $TOTALGROUPS security group"
else
    echo "There are $TOTALGROUPS security groups"
fi
echo "Security Group ID: $SECURITYGROUPID"