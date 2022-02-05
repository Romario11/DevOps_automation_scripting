
$stateArgument = $args[0]
$listOfInsatances = $args[1]

Write-Host $stateArgument
Write-Host
function stateOfInsatances {
    param (
        $listOfInsatances
    )
    foreach ($item in $listOfInsatances) {
        aws ec2 describe-instance-status --instance-id $item --query 'InstanceStatuses[*].[InstanceId , InstanceState.Name]' --output text
        Write-Host "-----------------------------------------------"
       } 
    
}
function stopInstances {
    param (
        $listOfInsatances
    )

    foreach ($item in $listOfInsatances) {
        aws ec2 stop-instances --instance-ids $item --query 'StoppingInstances[*].[{InstanceId: InstanceId}, CurrentState.{CurrentState: Name}, PreviousState.{PreviousState: Name}]'
        Write-Host "-----------------------------------------------"
    } 
}

function startInstances {
    param (
        $listOfInsatances
    )

    foreach ($item in $listOfInsatances) {
        aws ec2 start-instances --instance-ids $item --query 'StartingInstances[*].[{InstanceId: InstanceId}, CurrentState.{CurrentState: Name}, PreviousState.{PreviousState: Name}]'
        Write-Host "-----------------------------------------------"
    } 
}

if ($stateArgument -like "stop") {
    stopInstances($listOfInsatances)
}
elseif($stateArgument -like "start"){
    startInstances($listOfInsatances)
}elseif($stateArgument -like "state"){
    stateOfInsatances($listOfInsatances)
}else {
    Write-Host "Smething went wrong"
}
