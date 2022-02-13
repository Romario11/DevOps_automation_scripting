
# exemple: .\instance_startStopper.ps1 start eu-central-1 i-03013c23f3627ec35,i-03564d05062d4c6ea,i-0048dd187dce64e42
#------------name of script------------state--region--------instances ID without spaces, separete by coma------------
$stateArgument = $args[0]
$region = $args[1]
$listOfInsatances = $args[2]

Write-Host $stateArgument
Write-Host
function stateOfInsatances {
    param (
        $listOfInsatances
    )
    foreach ($item in $listOfInsatances) {
        aws ec2 describe-instance-status --instance-id $item --region $region --query 'InstanceStatuses[*].[InstanceId , InstanceState.Name]' --output text
        Write-Host "-----------------------------------------------"
       } 
    
}
function stopInstances {
    param (
        $listOfInsatances
    )

    foreach ($item in $listOfInsatances) {
        aws ec2 stop-instances --instance-ids $item --region $region --query 'StoppingInstances[*].[{InstanceId: InstanceId}, CurrentState.{CurrentState: Name}, PreviousState.{PreviousState: Name}]'
        Write-Host "-----------------------------------------------"
    } 
}

function startInstances {
    param (
        $listOfInsatances
    )

    foreach ($item in $listOfInsatances) {
        aws ec2 start-instances --instance-ids $item --region $region --query 'StartingInstances[*].[{InstanceId: InstanceId}, CurrentState.{CurrentState: Name}, PreviousState.{PreviousState: Name}]'
        Write-Host "-----------------------------------------------"
    } 
}

if ($stateArgument -like "stop") {
    stopInstances($listOfInsatances)
}
elseif($stateArgument -like "start"){
    startInstances($listOfInsatances)
}
elseif($stateArgument -like "state"){
    stateOfInsatances($listOfInsatances)
}
else {
    Write-Host "Smething went wrong"
}
