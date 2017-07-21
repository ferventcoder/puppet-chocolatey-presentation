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
  chocolatey_download_url => 'file:///C:/vagrant/resources/packages/chocolatey.0.10.3.nupkg',
  use_7zip                => false,
  log_output              => true,
}

chocolateyfeature {'checksumFiles':
  ensure => enabled,
}

chocolateyfeature {'allowEmptyChecksums':
  ensure => enabled,
}

chocolateyfeature {'virusCheck':
  ensure => enabled,
}

chocolateyfeature {'showNonElevatedWarnings':
  ensure => disabled,
}

chocolateyconfig {'cacheLocation':
  value => 'c:\ProgramData\choco-cache',
}

chocolateysource {'chocolatey':
  ensure   => present,
  location => 'https://chocolatey.org/api/v2/',
  priority => 10,
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
  ensure              => file,
  source              => 'C:/vagrant/resources/licensed/license/chocolatey.license.xml',
  source_permissions  => ignore,
}

# ensure the chocolatey.extension package is sitting in
# c:\vagrant\resources\packages
package {'chocolatey.extension':
  ensure  => latest,
  install_options => ['-pre'],
  require => File['C:/ProgramData/chocolatey/license/chocolatey.license.xml'],
}

package {'chocolatey-agent':
  ensure  => latest,
  install_options => ['-pre'],
  require => Package['chocolatey.extension'],
}

chocolateyfeature {'internalizeAppendUseOriginalLocation':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

chocolateyfeature {'allowPreviewFeatures':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

chocolateyconfig {'virusScannerType':
  value => 'VirusTotal',
  require => Package['chocolatey.extension'],
}

# for licensed edition demo
file {'C:/packages/installers':
  ensure => directory,
} ->

# ensure their are installers located in
# c:\vagrant\resources\licensed\createpackages\installers
file {'C:/packages/createpackages':
  ensure              => directory,
  source              => 'C:/vagrant/resources/licensed/createpackages',
  source_permissions  => ignore,
  recurse             => true,
}

## - END Licensed Demo Options

# demo templates folder
file {'C:/packages/templates':
  ensure              => directory,
  source              => 'C:/vagrant/resources/templates',
  source_permissions  => ignore,
  recurse             => true,
}

# Ensure tab completion
file {'C:/Users/Administrator/Documents/WindowsPowerShell':
  ensure => directory,
}

file {'C:/Users/Administrator/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1':
  ensure => file,
  content => '$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}',
}

# Ensure package installations

package {'roundhouse':
  ensure   => '0.8.5.0',
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
  provider 			=> chocolatey,
  uninstall_options => '--from-programs-and-features',
}

#latest
#installed

package {'launchy':
  ensure          => installed,
  install_options => ['--override', '--installArgs','"', '/VERYSILENT','/NORESTART','"'],
}

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
          'snagit',
          'nodejs',
          ]:
  ensure => latest,
  source => 'https://chocolatey.org/api/v2/',
}

package {'screentogif':
  ensure => '2.2.160907',
  source => 'https://chocolatey.org/api/v2/',
}

package {'dotnet4.5.2':
  ensure => latest,
}

# package {'chocolateygui':
#   ensure          => latest,
#   install_options => '--pre --ignore-dependencies',
#   require => Package['chocolatey.extension'],
# }

## Install Chocolatey Source

# this contains the bits to install the custom server
#include chocolatey_server
# OR
class {'chocolatey_server':
  server_package_source => 'C:/vagrant/resources/packages',
}

# Set up users
user {'nonAdmin':
  ensure      => present,
  groups      => ['Users'],
  managehome  => true,
  password    => 'nonadmin',
  comment     => 'Non administrative user',
}

user {'adminUser':
  ensure      => present,
  groups      => ['Users','Administrators'],
  managehome  => true,
  password    => 'adminuser',
  comment     => 'Administrative user',
}

# todo turn LUA all the way up (UAC)
