# source: 
# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-powershell
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs-copy
# https://www.sqlshack.com/use-azcopy-to-upload-data-to-azure-blob-storage/

# setups 
$name = "myolddevstorage"
$rg = 'my-resource-group'
$containerName = "mystoragecontainer"

# login 
# Connect-AzAccount

# use our storage accounts 
$storageAccount = Get-AzStorageAccount -ResourceGroupName $rg –StorageAccountName $name
$ctx = $storageAccount.Context

# create container 
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob

for ($i = 0; $i -lt 10; $i++) {
    # create new file 
    $new_file = New-Item blob$i.txt
    Set-Content blob$i.txt 'hello blob'

    # upload blobs to the container 
    Set-AzStorageBlobContent -File $new_file
        -Container $containerName `
        -Blob $new_file `
        -Context $ctx 

    # copy container from stroge A to storage B using azCopy
    #azcopy copy 'https://mysourceaccount.blob.core.windows.net/?sv=2018-03-28&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-07-04T05:30:08Z&st=2019-07-03T21:30:08Z&spr=https&sig=CAfhgnc9gdGktvB=ska7bAiqIddM845yiyFwdMH481QA8%3D' 'https://mydestinationaccount.blob.core.windows.net' --recursive

} 




