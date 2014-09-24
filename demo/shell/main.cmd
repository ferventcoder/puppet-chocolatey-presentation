echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallChocolatey.ps1"

echo 'Ensuring Time Service is on'
net start w32time
w32tm /resync

echo 'Ensuring TCP/IP NetBIOS Helper Service (lmhosts) is on'
sc config lmhosts start= auto
net start lmhosts

echo 'Install puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\InstallPuppetFromMSI.ps1"

:: Ensuring certificates are installed if box isn't updated
certutil -v -addstore Root "c:\vagrant\resources\certs\geotrust.global.pem"
certutil -v -addstore Root "c:\vagrant\resources\certs\usertrust.network.pem"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;

::echo "Ensuring environment for puppet - this puts the puppet ruby on the path for librarian"
::call environment.bat
::SET FACTER_domain=local

::echo 'Install Required libraries for puppet if missing'
::@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\shell\PreparePuppetProvisioner.ps1"
