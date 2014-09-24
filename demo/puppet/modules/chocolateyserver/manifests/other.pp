  # windowsfeature{'IIS':
  #   feature_name => ['Web-Server',
  #     'Web-WebServer',
  #     'Web-Asp-Net45',
  #     'Web-ISAPI-Ext',
  #     'Web-ISAPI-Filter',
  #     'NET-Framework-45-ASPNET',
  #     'WAS-NET-Environment',
  #     'Web-Http-Redirect',
  #     'Web-Filtering',
  #     'Web-Mgmt-Console',
  #     'Web-Mgmt-Tools']
  # } ->


  # windows_firewall::exception { 'Chocolatey Server Web':
  #   ensure       => present,
  #   direction    => 'in',
  #   action       => 'Allow',
  #   enabled      => 'yes',
  #   protocol     => 'TCP',
  #   port         => "${chocolatey_server_app_port}",
  #   display_name => 'Web Server HTTP-In',
  #   description  => 'Inbound rule for Chocolatey Web Server. [TCP 80]',
  # } ->
