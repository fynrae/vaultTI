param (
    [Parameter(Mandatory = $true)]
    [string]$Path
)

# Step 1: Take ownership of the folder and subfolders
takeown /F "$Path" /R /D Y

# Step 2: Reset permissions on the folder and subfolders
icacls "$Path" /reset /T /C

# Step 3: Grant full control to TrustedInstaller, with inheritance
icacls "$Path" /grant:r "NT SERVICE\TrustedInstaller:(OI)(CI)F" /T

# Step 4: Set TrustedInstaller as the owner of the folder and subfolders
$acl = Get-Acl "$Path"
$owner = New-Object System.Security.Principal.NTAccount("NT SERVICE\TrustedInstaller")
$acl.SetOwner($owner)
Set-Acl -Path $Path -AclObject $acl

Write-Host "'$Path' is now unlocked and TrustedInstaller is set as the owner."
