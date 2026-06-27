# Bulk Add Users to a Microsoft Teams Team Using PowerShell

## Prerequisites

* Windows PowerShell 5.1 or later
* Microsoft Teams PowerShell module
* Team Owner permissions
* User email addresses stored in `emails.csv`

---

## Step 1 – Install the Microsoft Teams PowerShell Module

Open **Windows PowerShell** and run:

```powershell
Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module MicrosoftTeams -Scope CurrentUser -Force -AllowClobber
```

---

## Step 2 – Import the Module

```powershell
Import-Module MicrosoftTeams
```

Verify the installation:

```powershell
Get-Module MicrosoftTeams -ListAvailable
```

---

## Step 3 – Connect to Microsoft Teams

```powershell
Connect-MicrosoftTeams
```

Sign in using your Microsoft 365 account when prompted.

---

## Step 4 – Obtain the Team Group ID

1. Open Microsoft Teams.
2. Navigate to the Team.
3. Click **⋯ (More options)**.
4. Select **Get link to team**.
5. Copy the link.

Example:

```text
https://teams.microsoft.com/l/team/19:xxxxxxxxxxxxxxxx@thread.tacv2/conversations?groupId=12345678-1234-1234-1234-123456789abc&tenantId=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Extract the **GroupId** value:

```text
12345678-1234-1234-1234-123456789abc
```

---

## Step 5 – Prepare the CSV File

Create a file named `emails.csv`.

Example:

```csv
Email
person1@example.com
person2@example.com
person3@example.com
```

---

## Step 6 – Test with a Single User

Before performing the bulk import, verify that the Group ID and permissions are correct.

```powershell
Add-TeamUser `
    -GroupId "12345678-1234-1234-1234-123456789abc" `
    -User "person1@example.com"
```

If the user is added successfully, proceed with the bulk import.

---

## Step 7 – Bulk Add Users

```powershell
$GroupId = "12345678-1234-1234-1234-123456789abc"

$success = @()
$failed = @()

Import-Csv ".\emails.csv" | ForEach-Object {

    $email = $_.Email

    Write-Host "Adding $email ..." -ForegroundColor Cyan

    try {
        Add-TeamUser `
            -GroupId $GroupId `
            -User $email `
            -ErrorAction Stop

        Write-Host "✓ Added $email" -ForegroundColor Green
        $success += $email
    }
    catch {
        Write-Host "✗ Failed $email" -ForegroundColor Yellow
        $failed += $email
    }

    Start-Sleep -Milliseconds 250
}

$success | Out-File Added.txt
$failed | Out-File Failed.txt

Write-Host ""
Write-Host "Completed!" -ForegroundColor Green
Write-Host "Added : $($success.Count)"
Write-Host "Failed: $($failed.Count)"
```

---

## Output

After completion, the following files are created:

| File         | Description                           |
| ------------ | ------------------------------------- |
| `Added.txt`  | List of successfully added users      |
| `Failed.txt` | List of users that could not be added |

The PowerShell console also displays the progress and a final summary.

---

## Notes

* Users who are already members are skipped.
* Invalid email addresses are reported in `Failed.txt`.
* A short delay (`250 ms`) between requests helps reduce Microsoft Teams API throttling.
* This approach is suitable for adding hundreds of users to an existing Microsoft Teams Team.
