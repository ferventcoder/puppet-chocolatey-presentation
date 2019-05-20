case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      source   => 'C:\vagrant\resources\packages',
    }
  }
}

#include chocolatey
# OR
class {'chocolatey':
  chocolatey_download_url => 'file:///C:/vagrant/resources/packages/chocolatey.0.10.8.nupkg',
  log_output              => true,
}

## If you need FIPS compliance
## make this the first thing you configure before you do any additional
## configuration or package installations
#chocolateyfeature {'useFipsCompliantChecksums':
#  ensure => enabled,
#}

## Keep chocolatey up to date based on your internal source
## You control the upgrades based on when you push an updated version
##  to your internal repository.
## Note the source here is to the OData feed, similar to what you see
##  when you browse to https://chocolatey.org/api/v2
package {'chocolatey':
  ensure          => latest,
  provider        => chocolatey,
  install_options => ['-pre'],
}

chocolateyfeature {'checksumFiles':
  ensure => enabled,
}

chocolateyfeature {'allowEmptyChecksums':
  ensure => enabled,
}

chocolateyfeature {'showNonElevatedWarnings':
  ensure => disabled,
}

chocolateyfeature {'useRememberedArgumentsForUpgrades':
  ensure => enabled,
}

chocolateyconfig {'cacheLocation':
  value => 'c:\ProgramData\choco-cache',
}

## Increase timeout to 4 hours
chocolateyconfig {'commandExecutionTimeoutSeconds':
  value => '14400',
}

chocolateysource {'chocolatey':
  ensure   => present,
  location => 'https://chocolatey.org/api/v2/',
  priority => 10,
}

## Install Chocolatey Source

# this contains the bits to install the custom server
#include chocolatey_server
# OR
class {'chocolatey_server':
  server_package_source => 'C:/vagrant/resources/packages',
}

chocolateysource {'internal_server':
  ensure   => present,
  location => 'http://localhost/chocolatey',
  priority => 1,
}

file { ['C:/ProgramData/chocolatey','C:/ProgramData/chocolatey/license','C:/ProgramData/chocolatey/templates']:
  ensure => directory,
}

file {'C:/packages':
  ensure => directory,
}

## - LICENSED DEMO OPTIONS -
# only set if you are using/evaluating the licensed edition

# ensure the license file is at
# c:\vagrant\resources\licensed\license\chocolatey.license.xml
file {'C:/ProgramData/chocolatey/license/chocolatey.license.xml':
  ensure             => file,
  source             => 'C:/vagrant/resources/licensed/license/chocolatey.license.xml',
  source_permissions => ignore,
}

# ensure the chocolatey.extension package is sitting in
# c:\vagrant\resources\packages
package {'chocolatey.extension':
  ensure          => latest,
  install_options => ['-pre'],
  require         => File['C:/ProgramData/chocolatey/license/chocolatey.license.xml'],
}

package {'chocolatey-agent':
  ensure          => latest,
  install_options => ['-pre'],
  require         => Chocolateyfeature['useLocalSystemForServiceInstalls'],
}

## ensure we set the user up properly
chocolateyfeature {'useLocalSystemForServiceInstalls':
  ensure  => disabled,
  require => Package['chocolatey.extension'],
}

## this is the default setting
chocolateyconfig {'serviceInstallsDefaultUserName':
  value   => 'ChocolateyLocalAdmin',
  require => Package['chocolatey.extension'],
}

## Ensure Admins (and Puppet) do not use the background service
chocolateyfeature {'useBackgroundServiceWithNonAdministratorsOnly':
  ensure  => enabled,
  require => Package['chocolatey-agent'],
}

chocolateyfeature {'useBackgroundService':
  ensure  => enabled,
  require => Chocolateyfeature['useBackgroundServiceWithNonAdministratorsOnly'],
}

## Package Internalizer enhancement
## See https://chocolatey.org/docs/features-automatically-recompile-packages
chocolateyfeature {'internalizeAppendUseOriginalLocation':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

## Package Reducer - keep space down
chocolateyfeature {'reduceInstalledPackageSpaceUsage':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

chocolateyfeature {'allowPreviewFeatures':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

chocolateyconfig {'virusScannerType':
  value   => 'VirusTotal',
  require => Package['chocolatey.extension'],
}

chocolateyfeature {'virusCheck':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

# for licensed edition demo
file {'C:/packages/installers':
  ensure => directory,
} ->

# ensure their are installers located in
# c:\vagrant\resources\licensed\createpackages\installers
file {'C:/packages/createpackages':
  ensure             => directory,
  source             => 'C:/vagrant/resources/licensed/createpackages',
  source_permissions => ignore,
  recurse            => true,
}

## - END Licensed Demo Options

# demo templates folder
file {'C:/packages/templates':
  ensure             => directory,
  source             => 'C:/vagrant/resources/templates',
  source_permissions => ignore,
  recurse            => true,
}

# Ensure tab completion
file {'C:/Users/Administrator/Documents/WindowsPowerShell':
  ensure => directory,
}

file {'C:/Users/Administrator/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1':
  ensure  => file,
  content => '$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}',
}

# Ensure package installations

package {'roundhouse':
  ensure => '0.8.5.0',
}

package {'git':
  ensure => latest,
}

package {'1password':
  ensure          => absent,
  install_options => ['--dir','c:\programs\1Password']
}

package { 'Bitvise SSH*':
  ensure            => absent,
  provider          => chocolatey,
  uninstall_options => '--from-programs-and-features',
}

#latest
#installed

package {'launchy':
  ensure          => installed,
  install_options => ['--override', '--installArgs','"', '/VERYSILENT','/NORESTART','"'],
}

#snagit requires 4.6.1
package {['virustotaluploader',
          'googlechrome',
          'notepadplusplus',
          '7zip',
          'ruby',
          'charles',
          'grepwin',
          'stexbar',
          'inkscape',
          'gitextensions',
          'pandoc',
          'nodejs',
          'baretail'
          ]:
  ensure => latest,
  source => 'https://chocolatey.org/api/v2/',
}

package {'screentogif':
  ensure => '2.2.160907',
  source => 'https://chocolatey.org/api/v2/',
}

# Set up users
user {'nonAdmin':
  ensure     => present,
  groups     => ['Users'],
  managehome => true,
  password   => 'nonadmin',
  comment    => 'Non administrative user',
}

user {'adminUser':
  ensure     => present,
  groups     => ['Users','Administrators'],
  managehome => true,
  password   => 'adminuser',
  comment    => 'Administrative user',
}

# todo turn LUA all the way up (UAC)

# package {'dotnet4.5.2':
#   ensure => latest,
#   notify => Reboot['pending_dot_net_install'],
# }

# reboot { 'pending_dot_net_install':
#   when => pending,
# }

# package {'chocolateygui':
#   ensure          => latest,
#   install_options => ['--pre','--ignore-dependencies'],
#   require         => Package['dotnet4.5.2'],
#   source          => 'https://www.myget.org/F/chocolateygui/',
# }
