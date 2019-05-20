Configuration SoftwareManagement
{
 Import-DscResource -Module cChoco
 Node "localhost"
 {
  LocalConfigurationManager
  {
    DebugMode = 'All'
  }

  cChocoInstaller chocoInstall
  {
    # default installation location - allows
    # Chocolatey to apply default security
    # settings
    InstallDir = "$env:ProgramData\chocolatey"
    ChocoInstallScriptUrl = 'file:///C:\vagrant\resources\dsc\InstallChocolatey.ps1'
  }

  cChocoSource DefaultChocoSource {
    Ensure    = 'Absent'
    Name      = 'chocolatey'
    Source    = 'https://chocolatey.org/api/v2/'
  }

  cChocoSource InternalChocoSource {
    Ensure    = 'Present'
    Name      = 'internal_server'
    Source    = 'http://localhost/chocolatey'
    #Credentials = add credentials
    Priority  = 1
  }

  cChocoPackageInstaller 1PasswordPackage
  {
    Name        = '1password'
    DependsOn   = "[cChocoInstaller]chocoInstall"
    AutoUpgrade = $True
  }
 }
}

if (Test-Path -Path .\SoftwareManagement) {Remove-Item .\SoftwareManagement -Force -Recurse }

SoftwareManagement

Start-DscConfiguration .\SoftwareManagement -Wait -Verbose -Force
