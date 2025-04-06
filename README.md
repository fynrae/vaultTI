# 🔒 VaultTI - TrustedInstaller File Locking & Unlocking Scripts

![PowerShell](https://img.shields.io/badge/PowerShell-Scripts-blue) ![Security](https://img.shields.io/badge/Privilege%20Escalation-Advanced-red)

## 📌 Description
VaultTI provides two advanced PowerShell scripts: `vaultti-lock.ps1` and `vaultti-unlock.ps1`. These scripts allow you to lock or unlock access to a specified folder or file, setting `TrustedInstaller` as the exclusive owner, thereby preventing unauthorized access.

> ⚠️ **Warning**: Misuse of these scripts could lead to accidental file lockout or loss of access. Use these scripts responsibly and only on systems you own or manage.

---

## 🧰 Files Included
### `vaultti-lock.ps1`
- **Locks** access to a folder or file by setting `TrustedInstaller` as the owner and restricting access from all other users, including Administrators.
- Removes all access control entries (ACEs) from the target and enforces strict control only by `TrustedInstaller`.

### `vaultti-unlock.ps1`
- **Unlocks** the folder or file by taking ownership, resetting permissions, and restoring `TrustedInstaller` as the owner with full access.

---

## 🔧 Requirements
- **Windows** with PowerShell
- **Administrator Rights** (required for changing ownership and ACLs)
- **SeDebugPrivilege** (for manipulating system services)

### 📦 Installing Required Modules
```powershell
Install-Module NtObjectManager -Scope CurrentUser -Force -SkipPublisherCheck
```

> You may need to bypass the PowerShell script execution policy:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

---

## 🚀 Usage Instructions

### 1️⃣ `vaultti-lock.ps1`
Locks the folder/file to `TrustedInstaller` by removing all other access permissions.

```powershell
# Run as Administrator
.\vaultti-lock.ps1 -Path "C:\Path\To\Folder"
```

This script:
- Takes ownership of the specified file/folder and sets `TrustedInstaller` as the owner.
- Removes any existing access rules, then adds Deny permissions for users like Administrators, SYSTEM, and Everyone.
- Only grants full control access to `TrustedInstaller`.

✅ Example Output:
```plaintext
✅ 'C:\Path\To\Folder' is now locked to TrustedInstaller. Access is denied to all others.
```

> **Warning**: Once locked, this folder will be inaccessible by any other users unless ownership and permissions are restored.

---

### 2️⃣ `vaultti-unlock.ps1`
Unlocks the folder/file by resetting ownership and permissions, and restoring access for `TrustedInstaller`.

```powershell
# Run as Administrator
.\vaultti-unlock.ps1 -Path "C:\Path\To\Folder"
```

This script:
- Takes ownership of the folder and its subfolders recursively.
- Resets the permissions to default values.
- Grants full control to `TrustedInstaller` and ensures it's set as the owner.

✅ Example Output:
```plaintext
'C:\Path\To\Folder' is now unlocked and TrustedInstaller is set as the owner.
```

---

## 🛡️ Security Warning
These scripts modify critical system permissions and ownerships. **Use them only on files and folders you manage**. Unauthorized use could lead to data inaccessibility or system instability.

---

## 🧪 Use Cases
- **File Protection**: Prevent unauthorized access or modification of important system files or folders by locking them to `TrustedInstaller`.
- **System Maintenance**: Ensure that only `TrustedInstaller` has access to system-critical directories while performing administrative tasks.
- **Security Research**: Use for exploration of Windows security boundaries and testing privilege escalation scenarios.

---

## 📄 License
These scripts are open-source under the [MIT License](LICENSE). Use at your own risk.

---

## 📬 Feedback & Contributions
Feel free to open issues or pull requests if you find bugs, want to add features, or improve functionality.

---

## 🙏 Acknowledgement
Special thanks to the PowerShell and Windows security communities for their ongoing research, resources, and contributions to system administration and privilege escalation techniques.

---

**Crafted for ethical hacking and administrative learning. Stay safe and responsible!** 🧠💻
