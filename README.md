# windows-hardening
A collection of tools &amp; scripts to harden the Windows Server hosting your DataMiner.

# Scripts

## Disable-LegacyProtocols.ps1

A script to change disable legacy SSL/TLS protocols on a Windows Server. They are disable for both client & server.
This script will disable SSL 2.0, SSL 3.0, TLS 1.0, TLS 1.1 and RC4 (128, 56, 40) cipher.

### Usage

Execute the script from an Administrator PowerShell console.

`.\Disable-LegacyProtocols.ps1`