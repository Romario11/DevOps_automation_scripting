#!/bin/bash

#./ipreleases.sh us-east-1 us-east-2 us-west-1 us-west-2 eu-central-1
#-script---------arguments with space separator----------------------


if [ -n "$1" ]
then
#arguments from user
listOfAWSRegions=$@
else
#default arguments
listOfAWSRegions="us-east-1 us-east-2 us-west-1 us-west-2 eu-central-1"
fi


echo 'Unassociated IP scaner'
#loop for AWS regions
for region in $listOfAWSRegions
do
echo "in region $region will be released next AllocationIds: "

listOfUnassociatedIPs="$listOfUnassociatedIPs $(aws ec2 describe-addresses --region $region --profile default \
 --query 'Addresses[?AssociationId==`null`].PublicIp[]' --output text)"

listOfUnassociatedAllocationId=$(aws ec2 describe-addresses --region $region --profile default \
 --query 'Addresses[?AssociationId==`null`].AllocationId[]' --output text)



if [ -z "$listOfUnassociatedAllocationId" ]
then
echo none
echo "---------------------------------------------------------"
else
for allocationId in $listOfUnassociatedAllocationId
do
echo $allocationId 
aws ec2 release-address --region $region --allocation-id $allocationId
echo "---------------------------------------------------------"
done
fi


done
echo "---------------------------------------------------------"


for ip in $listOfUnassociatedIPs
do
echo "$ip has been released"
done