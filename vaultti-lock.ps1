param (
    [Parameter(Mandatory = $true)]
    [string]$Path
)

if (-Not (Test-Path $Path)) {
    Write-Error "Path '$Path' does not exist."
    exit
}

# Get current ACL
$acl = Get-Acl -Path $Path

# Set owner to TrustedInstaller
$owner = New-Object System.Security.Principal.NTAccount("NT SERVICE\TrustedInstaller")
$acl.SetOwner($owner)

# Disable inheritance and remove all inherited rules
$acl.SetAccessRuleProtection($true, $false)

# Remove all existing rules
$acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) }

# Add Deny rules for everyone else
$denyUsers = @("Administrators", "SYSTEM", "Users", "Authenticated Users", "Everyone")

foreach ($denyUser in $denyUsers) {
    $denyRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        $denyUser,
        "FullControl",
        "ContainerInherit,ObjectInherit",
        "None",
        "Deny"
    )
    $acl.AddAccessRule($denyRule)
}

# Allow only TrustedInstaller full control
$tiRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "NT SERVICE\TrustedInstaller",
    "FullControl",
    "ContainerInherit,ObjectInherit",
    "None",
    "Allow"
)
$acl.AddAccessRule($tiRule)

# Apply the new ACL
Set-Acl -Path $Path -AclObject $acl

Write-Host "✅ '$Path' is now locked to TrustedInstaller. Access is denied to all others."
