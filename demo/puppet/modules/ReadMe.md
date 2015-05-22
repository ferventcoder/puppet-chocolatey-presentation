Please navigate up a directory on the command line and run the following:

`librarian-puppet install --clean --path=./modules`

It should set up the following:

 * puppetlabs/acl
 * rismoney/chocolatey
 * opentable/iis
 * puppetlabs/powershell
 * opentable/windowsfeature

 1. `puppet module install nameofmodule --modulepath .`
 1. Adjust module path as necessary depending on where you are calling this from, so that it points to this working directory.
