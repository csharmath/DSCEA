configuration MemberServerSecuritySettings {

    param(
        [string[]]$ComputerName="localhost"
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node $ComputerName {   
    
    #Anti-Malware
        Service MicrosoftAntimalwareService{
        Name = "MsMpSvc"
        StartupType = "Automatic"
        State = "Running"
        }
    
    #User Account Control
        Registry ConsentPromptBehaviorAdmin{
        Ensure = "Present"
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"
        ValueName = "ConsentPromptBehaviorAdmin"
        ValueType = "Dword"
        ValueData = "5"
        }  

        Registry PromptOnSecureDesktop{
        Ensure = "Present"
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"
        ValueName = "PromptOnSecureDesktop"
        ValueType = "Dword"
        ValueData = "1"
        }

	#Interactive logon: Number of previous logons to cache (in case domain controller is not available)
        Registry Numberofpreviouslogonstocache{
        Ensure = "Present"
        Key = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
        ValueName = "CachedLogonsCount"
        ValueType = "Dword"
        ValueData = "2"
        }

    #Checks to ensure that certain Windows Roles or Windows Features have not been installed
        WindowsFeature ActiveDirectoryDomainServices{
            Name = 'AD-Domain-Services'
            Ensure = 'Absent'
        }
	
		WindowsFeature DNSServer{
            Name = 'DNS'
            Ensure = 'Absent'
        }
    
	    WindowsFeature DHCPServer{
            Name = 'DHCP'
            Ensure = 'Absent'
        }

		WindowsFeature WindowsRoleFax{
            Name = 'Fax'
            Ensure = 'Absent'
        }

		#WindowsFeature TelnetServer {
        #    Name = 'Telnet-Server'
        #    Ensure = 'Absent'
        #}

        }
		        
}

MemberServerSecuritySettings