#Requires -RunAsAdministrator

<#
.SYNOPSIS
    A script to change disable legacy SSL/TLS protocols on a Windows Server. They are disable for both client & server.
.DESCRIPTION
    This script will disable SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1 and RC4 (128, 56, 40) cipher.
.EXAMPLE
    PS> .\Disable-LegacyProtocols.ps1
.LINK
    Find the latest version on GitHub: https://github.com/SkylineCommunications/windows-hardening
#>

#region Functions

Function Disable-LegacyProtocol {
    [CmdletBinding()]
    PARAM (
        [Parameter(Mandatory = $true)][string]$Name
    )

    $keyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\$Name"
    $clientKeyPath = "$keyPath\Client"
    $serverKeyPath = "$keyPath\Server"

    New-Item $serverKeyPath -Force | Out-Null
    New-ItemProperty -Path $serverKeyPath -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path $serverKeyPath -Name 'DisabledByDefault' -Value 1 -PropertyType 'DWord' -Force | Out-Null

    New-Item $clientKeyPath -Force | Out-Null
    New-ItemProperty -Path $clientKeyPath -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null
    New-ItemProperty -Path $clientKeyPath -Name 'DisabledByDefault' -Value 1 -PropertyType 'DWord' -Force | Out-Null
    Write-Host "Protocol $Name has been disabled."
}

Function Disable-LegacyCipher {
    [CmdletBinding()]
    PARAM (
        [Parameter(Mandatory = $true)][string]$Name
    )

    $basePath = "SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\$Name"
    $fullPath = "HKLM:\$basePath"
 
    # Workaround because New-Item doesn't support '/' in the Sub Key Name....
    ([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $env:COMPUTERNAME)).CreateSubKey($basePath) | Out-Null
    New-ItemProperty -Path $fullPath -Name 'Enabled' -Value '0' -PropertyType 'DWord' -Force | Out-Null

    Write-Host "Cipher $Name has been disabled."
}

#endregion

Write-Host "`nDisabling deprecated SSL/TLS protocols...`n"

# Disable legacy protocols
Disable-LegacyProtocol -Name 'SSL 2.0'
Disable-LegacyProtocol -Name 'SSL 3.0'
Disable-LegacyProtocol -Name 'TLS 1.0'
Disable-LegacyProtocol -Name 'TLS 1.1'

Write-Host "`nDisabling deprecated ciphers...`n"

# Disable legacy ciphers
Disable-LegacyCipher -Name 'RC4 128/128'
Disable-LegacyCipher -Name 'RC4 56/128'
Disable-LegacyCipher -Name 'RC4 40/128'

Write-Host "`nScript finished, reboot your machine for changes to take effect." -ForegroundColor Green