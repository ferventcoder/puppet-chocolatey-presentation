package {'name_of_package':
  provider => chocolatey,
  ensure   => absent, installed, latest, '1.0.0',
  source   => 'https://some_odata_feed/;c:\\local;\\some\network\share',
  install_options => '-installArgs "addtl args for native installer"',
}

package { "Git version 1.8.4-preview20130916":
  ensure    => installed,
  source    => 'C:\temp\Git-1.8.4-preview20130916.exe',
  install_options => ['/VERYSILENT']
}

package { 'git':
  ensure   => latest,
  provider => chocolatey,
}
