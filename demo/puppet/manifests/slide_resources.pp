package {'name_of_package':
  provider          => chocolatey,
  ensure            => absent, installed, latest, '1.0.0', held
  source            => 'https://some_odata_feed/;c:\\local;\\some\network\share',
  install_options   => ['-installArgs', '"','addtl', 'args', '"'],
  uninstall_options => ['-uninstallargs', '"','addtl', 'args', '"'],
}

package { "Git version 2.6.1":
  ensure    => installed,
  source    => 'C:\temp\Git-2.6.1-32-bit.exe',
  install_options => ['/VERYSILENT']
}

package { 'git':
  ensure   => latest,
}


include chocolatey

# OR

class {'chocolatey':
  chocolatey_download_url => 'http://url/to/chocolatey.nupkg',
  use_7zip                => false,
}
