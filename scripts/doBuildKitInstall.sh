#!/bin/sh

while [ -n "$1" ] ; do
  OPTION="$1"
  shift

  case "$OPTION" in
    
	-u|--user)
	  ## We've passed in the username from Azure in our ARM deployment JSON.
	  $USER = $1

## Set our Azure VM user to "NOPASSWD" mode for using sudo.

sudo echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-password

## Make sure we have the latest package lists.

sudo apt -y update

## Lets get rid of any outdated packages to start.

sudo apt -y upgrade

## Free up that precious disk space ;-).

sudo apt -y autoremove

## Run the BuildKit installer.

su $USER -c "curl -Ls https://civicrm.org/get-buildkit.sh | bash -s -- --full --dir ~/buildkit" -s /bin/sh $USER
