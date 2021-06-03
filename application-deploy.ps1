# download website zip
$ZipBlobUrl = 'https://github.com/raselahmmedgit/azureapps/raw/main/AzureAutoScalingTestApp.zip'
$ZipBlobDownloadLocation = 'D:\AzureAutoScalingTestApp.zip'
(New-Object System.Net.WebClient).DownloadFile($ZipBlobUrl, $ZipBlobDownloadLocation)

# extract downloaded zip
$UnzipLocation = 'C:\inetpub\wwwroot\'
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($ZipBlobDownloadLocation, $UnzipLocation)

# read write permission
$Path = "C:\inetpub\wwwroot"
$User = "IIS AppPool\DefaultAppPool"
$Acl = Get-Acl $Path
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($User, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $Path $Acl