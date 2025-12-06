Write-Output "Checkpointing Last Logged In User"
Write-Output "Creating a tracking file"

$trackingFile = New-Item -Path "C:\Program Files\RepairTech\Syncro\lastuser.tmp" -ItemType "file" -Force

(Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnDisplayName").LastLoggedOnDisplayName | Add-Content -Path $trackingFile 
(Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnSAMUser").LastLoggedOnSAMUser | Add-Content -Path $trackingFile 
(Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnUser").LastLoggedOnUser | Add-Content -Path $trackingFile 
(Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnUserSID").LastLoggedOnUserSID | Add-Content -Path $trackingFile 
(Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "SelectedUserSID").SelectedUserSID | Add-Content -Path $trackingFile 

$name = (Get-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnDisplayName").LastLoggedOnDisplayName | Out-String

Write-Output "User $name has been marked as the checkpoint"
