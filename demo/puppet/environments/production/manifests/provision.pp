case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      source   => 'C:\vagrant\resources\packages',
    }
  }
}

#include chocolatey
class {'chocolatey':
  chocolatey_download_url => 'file:///C:/vagrant/resources/packages/chocolatey.0.10.3.nupkg',
  use_7zip                => false,
  log_output              => true,
} ->

file { ['C:/ProgramData/chocolatey','C:/ProgramData/chocolatey/license','C:/ProgramData/chocolatey/templates']:
  ensure => directory,
} ->

file {'C:/ProgramData/chocolatey/license/chocolatey.license.xml':
  ensure              => file,
  source              => 'C:/vagrant/resources/licensed/license/chocolatey.license.xml',
  source_permissions  => ignore,
}

chocolateyfeature {'checksumFiles':
  ensure => enabled,
}

chocolateyfeature {'virusCheck':
  ensure => enabled,
}

chocolateyfeature {'internalizeAppendUseOriginalLocation':
  ensure  => enabled,
  require => Package['chocolatey.extension'],
}

chocolateyconfig {'virusScannerType':
  value => 'VirusTotal',
  require => Package['chocolatey.extension'],
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
  location => 'http://somewhere/internal',
  priority => 1,
}

file { ['C:/packages', 'C:/packages/installers']:
  ensure => directory,
} ->

file {'C:/packages/createpackages':
  ensure              => directory,
  source              => 'C:/vagrant/resources/licensed/createpackages',
  source_permissions  => ignore,
  recurse             => true,
} ->

file {'C:/packages/templates':
  ensure              => directory,
  source              => 'C:/vagrant/resources/templates',
  source_permissions  => ignore,
  recurse             => true,
}

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

# this contains the bits to install the custom server
# include chocolatey_server
class {'chocolatey_server':
  server_package_source => 'C:/vagrant/resources/packages',
}

package { 'chocolatey.extension':
  ensure => latest,
}

package {'roundhouse':
  ensure   => '0.8.5.0',
}

package {'git':
  ensure => latest,
}

package {'1password':
  ensure          => absent,
  install_options => ['--dir','c:\1Password']
}

#latest
#installed

package {'launchy':
  ensure          => installed,
  install_options => ['-override', '-installArgs','"', '/VERYSILENT','/NORESTART','"'],
}
