Add-WindowsFeature AD-Domain-Services

Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\\Windows\\NTDS" -DomainMode "7" -DomainName "NAME.local" -DomainNetbiosName "NAME" -ForestMode "7" -InstallDns:$true -LogPath "C:\\Windows\\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\\Windows\\SYSVOL" -Force:$true

IEX((new-object net.webclient).downloadstring("https://raw.githubusercontent.com/WaterExecution/vulnerable-AD-plus/master/vulnadplus.ps1"));
Invoke-VulnAD -UsersLimit 100 -DomainName "NAME.local"
