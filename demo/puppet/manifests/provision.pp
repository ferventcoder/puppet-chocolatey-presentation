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
  chocolatey_download_url => 'file:///C:/vagrant/resources/packages/chocolatey.0.9.9.11.nupkg',
  use_7zip                => false,
  log_output              => true,
}

# disable default source
chocolatey::source {'chocolatey':
  enable => false,
}

# chocolatey::source {'localpackages':
#   ensure    => 'present',
#   location  => 'C:\vagrant\resources\packages'
# }

# this contains the bits to install the custom server
include chocolatey_server

chocolatey::source {'localhost':
  ensure    => 'present',
  location  => 'http://localhost/chocolatey',
}

# chocolatey_source {'local':
#   ensure    => 'present',
#   location  => 'http://localhost/chocolatey',
# }


package {'roundhouse':
  ensure   => '0.8.5.0',
}

# package {'roundhouse':
#   ensure   => held,
# }

package {'launchy':
  ensure          => installed,
  install_options => ['-override', '-installArgs','"', '/VERYSILENT','/NORESTART','"'],
}



















