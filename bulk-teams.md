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
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
    [string]$GroupId,

    [Parameter(Mandatory = $true)]
    [string]$CsvPath,

    [ValidateRange(0, 60000)]
    [int]$DelayMilliseconds = 250
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command Add-TeamUser -ErrorAction SilentlyContinue)) {
    throw "Add-TeamUser is unavailable. Import MicrosoftTeams and connect first."
}

if (-not [System.IO.Path]::IsPathRooted($CsvPath)) {
    $CsvPath = Join-Path (Get-Location) $CsvPath
}

if (-not (Test-Path -LiteralPath $CsvPath -PathType Leaf)) {
    throw "CSV file not found: $CsvPath"
}

$CsvPath = (Resolve-Path -LiteralPath $CsvPath).Path
$users = @(Import-Csv -LiteralPath $CsvPath)

if ($users.Count -eq 0) {
    throw "The CSV contains no user records: $CsvPath"
}

if (-not ($users[0].PSObject.Properties.Name -contains "Email")) {
    throw "The CSV must contain a column named Email."
}

$csvBaseName = [System.IO.Path]::GetFileNameWithoutExtension($CsvPath)
$outputDirectory = Split-Path -Parent $CsvPath
$addedPath = Join-Path $outputDirectory "Added-$csvBaseName.txt"
$failedPath = Join-Path $outputDirectory "Failed-$csvBaseName.txt"

$success = [System.Collections.Generic.List[string]]::new()
$failed = [System.Collections.Generic.List[string]]::new()

foreach ($record in $users) {
    $email = [string]$record.Email
    $email = $email.Trim()

    if ([string]::IsNullOrWhiteSpace($email)) {
        continue
    }

    Write-Host "Adding $email ..." -ForegroundColor Cyan

    try {
        Add-TeamUser `
            -GroupId $GroupId `
            -User $email `
            -ErrorAction Stop

        Write-Host "Added $email" -ForegroundColor Green
        $success.Add($email)
    }
    catch {
        $message = $_.Exception.Message
        Write-Host "Failed $email - $message" -ForegroundColor Yellow
        $failed.Add("$email`t$message")
    }

    if ($DelayMilliseconds -gt 0) {
        Start-Sleep -Milliseconds $DelayMilliseconds
    }
}

$success | Set-Content -LiteralPath $addedPath -Encoding UTF8
$failed | Set-Content -LiteralPath $failedPath -Encoding UTF8

Write-Host ""
Write-Host "Import completed." -ForegroundColor Green
Write-Host "Team Group ID: $GroupId"
Write-Host "CSV          : $CsvPath"
Write-Host "Added        : $($success.Count)"
Write-Host "Failed       : $($failed.Count)"
Write-Host "Added log    : $addedPath"
Write-Host "Failed log   : $failedPath"

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
