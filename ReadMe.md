Puppet On Windows
==================================

## Prerequisites

 * [Vagrant 1.5.4](http://downloads.vagrantup.com/tags/v1.5.4) or greater.
 * [VirtualBox 4.2.16](https://www.virtualbox.org/wiki/Downloads) or VMWare Fusion 5
    * If you want to use VMWare Fusion you will also need the vagrant-vmware-fusion plugin for vagrant (which is not free). You also want the latest version (at least 0.8.5).
 * Vagrant-Windows
 * At least 20GB free on the host box.
 * Vagrant Sahara plugin for sandboxing.

## Setup

 1. Install/upgrade Vagrant to 1.5.4.
 1. Install/upgrade VirtualBox/VMWare to versions listed above.
 1. Install/upgrade required plugins for vagrant (if using VMWare you will need the non-free vagrant-vmware-fusion or equivalent).
 1. Vagrant 1.5.4 (and below) - Install/upgrade vagrant-windows vagrant plugin. Open terminal/command line and type `vagrant plugin install vagrant-windows`
 1. Install/upgrade `sahara` vagrant plugin - `vagrant plugin install sahara`.


## Presentation

The presentation is in keynote but there are other formats in the `Presentation` directory.

## Demo

### Exercise 0 - Vagrant Box Prep

 1. Obtain a 2012 Windows vagrant box.
   1. You may need to update the box name to something from vagrantcloud/opentable.
 1. Now install the required modules (demo/puppet/modules/readme.md)
 1. Call `vagrant up` and wait for it to run the shell provisioner.
 1. Now we are ready to grab a snapshot for the demo. Call `vagrant sandbox on`
 1. In `demo/Vagrantfile` please comment out the shell provisioner and change the puppet provisioner to `provision.pp` that is currently set to `puppet.manifest_file  = "empty.pp"`.
 1. This concludes exercise 0.

### Exercise 1 - Create a package

 1. From the box, navigate to `c:\vagrant\packages` on the command line or powershell.
 1. Follow the instructions to get setup for [templates](https://github.com/chocolatey/chocolateytemplates/blob/master/README.md).
 1. Run `warmup chocolatey mypackage`.
 1. Edit `mypackage/mypackage.nuspec` to remove items that end in url.
 1. Change the version to `0.1.0`.
 1. Save and close the nuspec.
 1. Edit `mypackage/tools/chocolateyInstall.ps1`. Make it look like:
    $packageName = 'mypackage'
    Write-Host "$packageName has been installed."
 1. Save and close the file.
 1. Run `choco pack`.
 1. Note that there is now a `.nupkg` file in the directory.
 1. Optionally open it with NuGet Package Explorer if you have that installed and inspect how everything is laid out.
 1. This concludes exercise 1.

### Exercise 2 - Create a package server.

 1. From the host, access `http://localhost:8080` (unless it conflicted, adjust as vagrant tells you the port is forwarded to). It should show nothing.
 1. In `demo/puppet/manifests/provision.pp`, uncomment `include chocolateyserver`
 1. Run `vagrant provision` and wait for it to finish.
 1. Now access `http://localhost:8080` again. Note the information displayed.
 1. On the box itself, access `http://localhost`. Note the additional information displayed when you are local.
 1. This concludes exercise 2.

### Exercise 3 - Put a created package on the custom package server
Now that we've created a custom package and we've created a custom package server, it only makes sense that we want to get our package up on that server.

 1. Access `http://localhost`. Click on the link for packages. Show how their are none there.
 1. Navigate to the directory where you created the nupkg file from prior exercises.
 1. Run `choco push pkgname.nupkg -s http://localhost`. You should receive some errors.
 1. If you are on new choco, just add in the apikey to the push command `-k chocolateyrocks`. If you are on old choco:
   1. `choco install nuget.commandline`
   1. `nuget setapikey chocolateyrocks -source http://localhost/chocolatey`
 1. Run `choco push pkgname.nupkg -s http://localhost -k chocolateyrocks`. You will probably get an error here. Point out this is the most common mistake folks make. The location you query and the location you push to are always slightly different.
 1. Run `choco push pkgname.nupkg -s http://localhost/chocolatey -k chocolateyrocks`.
 1. Note how the command succeeds.
 1. Access `http://localhost`. Click on the link for packages. Note how there is package metadata now.
 1. Show the package in the folder at `c:\tools\chocolatey.server\AppData\packages`.
 1. This concludes exercise 3.

### Exercise 4 - Install custom package

 1. Run `choco install mypackage -s http://localhost`.
 1. Note what happens.
 1. This concludes exercise 4.
