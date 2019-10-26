#!/bin/sh

while [ -n "$1" ] ; do
  option="$1"
  shift

  case "$option" in
    
	-u|--user)
	  ## We've passed in the username from Azure in our ARM deployment JSON.
	  adminuser="$1"
	  shift
	  ;;
	
	-ut|--url-template)
	  ## We've passed in the URL template for Azure in our ARM deployment JSON.
	  urltemplate="$1"
	  shift
	  ;;
  esac
done

## Set our Azure VM user to "NOPASSWD" mode for using sudo.

sudo echo "$adminuser ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/dont-prompt-$adminuser-for-password"

## Set debconfig for non-interactive mode.

sudo echo 'debconf debconf/frontend select noninteractive' | debconf-set-selections

## Make sure we have the latest package lists.

sudo apt-get -y update

## Lets get rid of any outdated packages to start.

sudo apt-get -y upgrade

## Free up that precious disk space ;-).

sudo apt-get -y autoremove

## Make sure we have CURL installed.

sudo apt-get -y install curl

## Setup a Buildkit group.

sudo groupadd buildkit

## Add "$adminuser" to Buildkit group.

sudo usermod -a -G buildkit "$adminuser"

## Create directory.

sudo mkdir /opt/buildkit

## Grant Read/Write/Execute permissions to Buildkit group.
sudo setfacl -m g:buildkit:rwx /opt/buildkit
sudo setfacl -m d:g:buildkit:rwx /opt/buildkit

## Set working directory.

cd /home/"$adminuser"/ || return

## Run the BuildKit installer.

sudo -i -u "$adminuser" curl -Ls https://civicrm.org/get-buildkit.sh | sudo -i -u "$adminuser" bash -s -- --full --dir /opt/buildkit

## Set an Environment Variable for the URL Template

sudo echo "URL_TEMPLATE=\"http://%SITE_NAME%.${urltemplate}\"" | sudo tee -a /etc/environment

## Add profile script for BuildKit path.

sudo curl -O https://lab.civicrm.org/MikeyMJCO/civicrm-buildkit-azuredeploy/raw/master/scripts/10-buildkit-path.sh
sudo mv 10-buildkit-path.sh /etc/profile.d/
sudo chmod +x /etc/profile.d/10-buildkit-path.sh