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
    ChocoInstallScriptUrl = 'file:///C:\vagrant\shell\InstallChocolatey.ps1'
  }

  cChocoPackageInstaller 1PasswordPackage
  {
    Name        = '1password'
    DependsOn   = "[cChocoInstaller]chocoInstall"
    AutoUpgrade = $True
    chocoParams = '--source internal_server'
  }
 }
}

if (Test-Path -Path .\SoftwareManagement) {Remove-Item .\SoftwareManagement -Force -Recurse }

SoftwareManagement

Start-DscConfiguration .\SoftwareManagement -Wait -Verbose -Force
