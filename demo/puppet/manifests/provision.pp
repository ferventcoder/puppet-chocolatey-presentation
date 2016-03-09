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

# this contains the bits to install the custom server
# include chocolatey_server
class {'chocolatey_server':
  server_package_source => 'C:/vagrant/resources/packages',
}

package {'roundhouse':
  ensure   => '0.8.5.0',
}
#latest
#installed

package {'launchy':
  ensure          => installed,
  install_options => ['-override', '-installArgs','"', '/VERYSILENT','/NORESTART','"'],
}



















