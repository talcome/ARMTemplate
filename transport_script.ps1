# source: 
# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-powershell
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs-copy
# https://www.sqlshack.com/use-azcopy-to-upload-data-to-azure-blob-storage/
# https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-copy

# setups 
$srcName = "myolddevstorage"
$destName="mynewdevstorage"
$rg = "my-resource-group"
$containerName = "mystoragecontainer"
$repo="files"

# login 
Connect-AzAccount

# use our storage accounts 
$storageAccount = Get-AzStorageAccount -ResourceGroupName $rg –StorageAccountName $srcName
$ctx = $storageAccount.Context

# create container 
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob

# create folder 
New-Item -Path $repo -ItemType Directory

for ($i = 0; $i -lt 100; $i++) { 
    # create new file 
    New-Item $repo/blob$i.txt -ItemType File
    Set-Content $repo/blob$i.txt 'hello from blob'
}  

# upload blobs to the container 
Get-ChildItem -File $repo -Recurse | Set-AzStorageBlobContent -Container $containerName -Blob $blobName -Context $ctx 

# use our storage accounts 
$storageAccount = Get-AzStorageAccount -ResourceGroupName $rg –StorageAccountName $destName
$ctx = $storageAccount.Context

# create container 
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob

# copy container from stroge A to storage B using azCopy
./azcopy login --tenant-id "72f988bf-86f1-41af-91ab-2d7cd011db47"
./azcopy copy "https://myolddevstorage.blob.core.windows.net/mystoragecontainer?sv=2020-08-04&ss=b&srt=co&sp=rwdlactfx&se=2021-08-30T23:15:04Z&st=2021-08-15T15:15:04Z&spr=https&sig=bbllENmCnVROtzoxTWrR%2FBJhXFQ%2BfruufjBNOISr6tQ%3D" "https://mynewdevstorage.blob.core.windows.net/mystoragecontainer" --recursive
