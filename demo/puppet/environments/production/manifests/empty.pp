exec { 'test environment variables':
  command     => 'Write-Output "TESTVALUE = $env:TESTVALUE"',
  provider    => powershell,
  logoutput   => true,
  environment => "TESTVALUE=YES",
}
