choco source disable -n chocolatey
choco source add -n vagrant -s c:\vagrant\resources\packages
choco feature disable -n useBackgroundServiceWithNonAdministratorsOnly
choco feature disable -n logValidationResultsOnWarnings