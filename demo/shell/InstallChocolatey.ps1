$ChocoInstallPathOld = "$env:SystemDrive\Chocolatey\bin"
$ChocoInstallPath = "$env:SystemDrive\ProgramData\chocolatey\bin"

$env:Path += ";$ChocoInstallPath"

if (!(Test-Path $ChocoInstallPath)) {
  # Install chocolatey
  iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}

#choco install chocolatey -pre
# $resourcesPath = 'c:\vagrant\resources'
# $chocoPkgFile = get-childitem $resourcesPath -recurse -include 'chocolatey.*.nupkg' | select -First 1

# if ($chocoPkgFile -ne $null) {
#   cinst chocolatey -pre -force -source "$resourcesPath"
# } else {
#   cinst chocolatey -pre
# }
