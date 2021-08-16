$rg="my-resource-group"
$location="eastus"

New-AzResourceGroup -Name $rg -Location $location -Force

New-AzResourceGroupDeployment `
    -Name "new-deploy" `
    -ResourceGroupName $rg `
    -TemplateFile "storage_template.json" `
    -storageName 'myolddevstorage' `
    -