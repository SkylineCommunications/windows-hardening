#Requires -RunAsAdministrator

<#
.SYNOPSIS
    A script to change disable legacy SSL/TLS protocols on a Windows Server. They are disable for both client & server.
.DESCRIPTION
    This script will disable SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1 and RC4 cipher.
.EXAMPLE
    PS> .\Disable-LegacyProtocols.ps1
.LINK
    Find the latest version on GitHub: https://github.com/SkylineCommunications/windows-hardening
#>

# Disable SSL 2.0
$ssl2 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0'
$ssl2Client = "$ssl2\Client"
$ssl2Server = "$ssl2\Server"

New-Item $ssl2Server -Force | Out-Null
New-ItemProperty -path $ssl2Server -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $ssl2Server -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
New-Item $ssl2Client -Force | Out-Null
New-ItemProperty -path $ssl2Client -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $ssl2Client -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 2.0 has been disabled.'

# Disable SSL 3.0
$ssl3 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0'
$ssl3Client = "$ssl3\Client"
$ssl3Server = "$ssl3\Server"

New-Item $ssl3Server -Force | Out-Null
New-ItemProperty -path $ssl3Server -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $ssl3Server -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
New-Item $ssl3Client -Force | Out-Null
New-ItemProperty -path $ssl3Client -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $ssl3Client -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
Write-Host 'SSL 3.0 has been disabled.'

# Disable TLS 1.0
$tls10 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0'
$tls10Client = "$tls10\Client"
$tsl10Server = "$tls10\Server"

New-Item $tsl10Server -Force | Out-Null
New-ItemProperty -path $tsl10Server -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $tsl10Server -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
New-Item $tls10Client -Force | Out-Null
New-ItemProperty -path $tls10Client -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $tls10Client -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.0 has been disabled.'

# Disable TLS 1.1
$tls11 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1'
$tls11Client = "$tls11\Client"
$tsl11Server = "$tls11\Server"

New-Item $tsl11Server -Force | Out-Null
New-ItemProperty -path $tsl11Server -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $tsl11Server -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
New-Item $tls10Client -Force | Out-Null
New-ItemProperty -path $tls11Client -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null
New-ItemProperty -path $tls11Client -name 'DisabledByDefault' -value 1 -PropertyType 'DWord' -Force | Out-Null
Write-Host 'TLS 1.1 has been disabled.'

# Disable RC4
$rc4 = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4'

([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128')
New-ItemProperty -path "$rc4 128/128" -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null

([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128')
New-ItemProperty -path "$rc4 40/128" -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null

([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128')
New-ItemProperty -path "$rc4 56/128" -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null 
Write-Host 'RC4 has been disabled.'
