# default signifies all nodes (aka agents)
node default {

  # file { 'c:/temp':
  #   ensure => 'directory',
  #   notify => File['c:/temp/testfile.txt'],
  # }

  # file { 'c:/temp/testfile.txt':
  #   ensure => 'file',
  #   content => 'Test file',
  # }
  # package {'putty':
  #   ensure => '0.62',
  #   provider => chocolatey,
  # }

  # package {'roundhouse':
  #   ensure => latest,
  #   provider => chocolatey,
  #   source => 'c:\vagrant\resources\packages',
  #   #install_options => '-pre'
  # }

  # service {'BITS':
  #   ensure => 'stopped',
  #   enable => 'manual',
  # }

  # package {'vcredist2008':
  #   ensure => latest,
  #   provider => chocolatey,
  #   notify => Reboot['reboot_vcredist'],
  # }

  # reboot { 'reboot_vcredist':
  #   message => "Rebooting for Redist",
  #   when => pending,
  #   timeout => 5,
  # }

  # registry_key {'HKLM\System\TestKey':
  #   ensure => present,
  # } ->
  # registry_value {'HKLM\System\TestKey\TestValue':
  #   ensure => present,
  #   type => string,
  #   data => "Just a key for testing",
  # }

  # dism {'NetFx4':
  #   ensure => present,
  #   notify => Reboot['reboot_netfx'],
  # }

  # reboot { 'reboot_netfx':
  #   message => "Rebooting for Net Framework install",
  #   when => pending,
  #   timeout => 5,
  # }

  # user {'Administrator':
  #   ensure => present,
  # }

}
