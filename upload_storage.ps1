$rg = 'my-resource-group'
New-AzResourceGroup -Name $rg -Location eastus -Force

New-AzResourceGroupDeployment -Name 'azuredeploy' -ResourceGroupName $rg -TemplateFile 'mynewdevstorage.json'
