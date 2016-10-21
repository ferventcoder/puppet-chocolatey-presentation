$path = 'installers'

# Generate packages over supported types of files
$supportedTypes = @('.exe', '.msi', '.7z', '.zip', '.msu', '.msp')
Get-ChildItem -Path $path | ?{
  $extension = [System.IO.Path]::GetExtension($_.Name)
  $supportedTypes.Contains($extension)
} | %{
  Write-Host "$($_.FullName)"
  & choco new --file "$($_.FullName)" --build-package --outputdirectory $pwd
}

# Run against 32 & 64 bit file
& choco new --file '\\localhost\c$\packages\createpackages\installers\git\Git-2.7.0-32-bit.exe' --file64 '\\localhost\c$\packages\createpackages\installers\git\Git-2.7.0-64-bit.exe' --build-package --outputdirectory $pwd --use-original-location

# Download and create a package from urls
& choco new --url 'https://nodejs.org/dist/v6.6.0/node-v6.6.0-x86.msi' --url64 'https://nodejs.org/dist/v6.6.0/node-v6.6.0-x64.msi' --checksum '8CE48431E7D0182D21EFC398FCC478F8852B96DF8A7287DD40DB9EF53CCA01A3' --checksum64 '675F5088021B99C53136D9F7306BA93F2A126DF75777F0B97FB6013DA2E5C539' --checksum-type 'sha256'
