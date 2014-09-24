## Offline mode

If you need to demo in offline mode, add packages here and edit them to point to locally downloaded installers.
 1. Download the packages from chocolatey.org (download link on the left).
   1. You need `roundhouse`, `notepadplusplus.commandline`, `putty`, `launchy`, `windirstat` and `chocolatey.server`.
 1. `choco install nugetpackageexplorer`.
 1. Open the package with NPE (NuGet Package Explorer).
 1. In each package, if there is a download link, you will need to edit this package.
 1. Use the link to download the file locally here.
 1. Edit the package inside of NPE to point to the location of the local file. The link will be similar to `
$url = 'file:///c:/vagrant/resources/packages/windirstat1_1_2_setup.exe'`
 1. Edit `demo/puppet/manifests/provision.pp` to uncomment the default Package resource to point to this location.
 1. Edit `demo/puppet/modules/chocolateyserver/manifests/init.pp` to uncomment the `source =>` pointer to this location.
