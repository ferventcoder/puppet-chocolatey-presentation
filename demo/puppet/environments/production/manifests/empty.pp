 Exec {
  provider  => powershell,
  logoutput => true,
}

exec {'sleep command with timeout - should never timeout':
  command   => 'Write-Host "Going to sleep now..."; Start-Sleep 50',
  timeout   => 0,
}

exec {'sleep command with timeout retries - should fail':
  command   => 'Write-Host "Going to sleep now..."; Start-Sleep 50',
  timeout   => 2,
  tries     => 2,
  try_sleep => 1,
}
