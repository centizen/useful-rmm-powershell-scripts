#Requires a Syncro toggle variable called $removeCheckpoint with the options of either "Yes" or "No"

Write-Output "Recalling Last Logged In User"

Write-Output "Checking to see if tracking file exists"

if (-Not (Test-Path "C:\Program Files\RepairTech\Syncro\lastuser.tmp") ) {
    Write-Output "Checkpoint file does not exist, sorry"
    Exit
}

[String[]]$userData = Get-Content -Path "C:\Program Files\RepairTech\Syncro\lastuser.tmp"

Set-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnDisplayName" -Value $userData[0]
Set-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnSAMUser" -Value $userData[1]
Set-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnUser" -Value $userData[2]
Set-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "LastLoggedOnUserSID" -Value $userData[3]
Set-ItemProperty -Path 'HKLM:\\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name "SelectedUserSID" -Value $userData[4]

$name = $userData[0]

Write-Output "User $name has been recalled"

if ($removeCheckpoint -eq "Yes") { Remove-Item -Path "C:\Program Files\RepairTech\Syncro\lastuser.tmp" }
