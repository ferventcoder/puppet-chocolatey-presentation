case $operatingsystem {
  'windows':    {
    Package {
      provider => chocolatey,
      source   => 'C:\vagrant\resources\packages',
    }
  }
}

package {'puppet-agent':
  ensure          => latest,
  install_options => ['--log-file=C:\vagrant\logs\choco.log','--trace']
}
