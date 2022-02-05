for region in $listOfAWSRegions
do
echo "in region $region will be released next EIPs "
for addresses in $(aws ec2 describe-addresses --region $region --profile default --query 'Addresses[?AssociationId==`null`].AllocationId[]' --output text)
do
echo $addresses
aws ec2 release-address --region $region --allocation-id $addresses
listOfUnassociatedIPs="$listOfUnassociatedIPs $addresses"
done
done
echo "---------------------------------------------------------"

for ip in $listOfUnassociatedIPs
do
echo $ip
#aws ec2 release-address --public-ip $ip
echo "$ip has been released"
done