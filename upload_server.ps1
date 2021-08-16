$resourceGroupName="my-resource-group"
$location="eastus"
$adminUsername="talkome"
$adminPassword="311148902Kotal"
$dnsLabelPrefix="dev"

New-AzResourceGroup -Name $resourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri "ARMServer.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix

 (Get-AzVm -ResourceGroupName $resourceGroupName).name
