# Terraform AWS Infrastructure for Vulnerable Windows Domain Controller, Windows Server, and Linux Server

This repository contains Terraform scripts to deploy a vulnerable infrastructure in AWS for testing. The infrastructure includes a Windows Domain Controller, a Windows Server, and a Linux Server for testing and educational purposes.

## Credits

Special thanks to [WaterExecution](https://github.com/WaterExecution) for providing the PowerShell script used in this project. You can find the original script [here](https://github.com/WaterExecution/vulnerable-AD-plus).


## Before deploying


2. Open the `main.tf` file and replace the following placeholders:

   - `access_key` and `secret_key` in the AWS provider block with your AWS credentials.
   - `My-KP` in the AWS instances blocks with your key pair name.

3. Edit a `var.tf` file with the required variables:

    ```hcl
    FIRST_DC_IP = "172.16.10.100"
    SECOND_SERVER_IP = "172.16.10.90"
    LINUX_IP = "172.16.10.80"
    PUBLIC_DNS = "1.1.1.1"
    MANAGEMENT_IPS = ["/32"] # Add your IP here!
    DC_SUBNET_CIDR = "172.16.10.0/24"
    My-KP = "" # Add your key here!
    ```


## PowerShell Script

The `Vuln-DC.ps1` script included in this repository sets up a vulnerable Active Directory environment. It installs the necessary features and configures the domain controller. Make sure to review and customize the script according to your needs.

```powershell
Add-WindowsFeature AD-Domain-Services

Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\\Windows\\NTDS" -DomainMode "7" -DomainName "NAME.local" -DomainNetbiosName "NAME" -ForestMode "7" -InstallDns:$true -LogPath "C:\\Windows\\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\\Windows\\SYSVOL" -Force:$true

IEX((new-object net.webclient).downloadstring("https://raw.githubusercontent.com/WaterExecution/vulnerable-AD-plus/master/vulnadplus.ps1"));
Invoke-VulnAD -UsersLimit 100 -DomainName "NAME.local"
