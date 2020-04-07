#!/bin/bash


function GTERM_LOAD()
{
	GTERM_DIR="$HOME/.gterm"
	GTERM_FILE="$GTERM_DIR/gterm-profile.dconf"
	GTERM_RC="$GTERM_DIR/gterm.rc"
	GTERM_URL="https://raw.githubusercontent.com/rm-tic/vagabondv2/master/gterm-profile.dconf"


	if [ "$(cat $GTERM_RC 2> /dev/null)" != "0" ]; then

		mkdir $GTERM_DIR 2> /dev/null

		wget -qO $GTERM_FILE $GTERM_URL

		#DCONF EXPORT
		#dconf dump /org/gnome/terminal/legacy/profiles:/ > $GTERM_FILE
		
		#DCONF IMPORT
		dconf load /org/gnome/terminal/legacy/profiles:/ < $GTERM_FILE

		echo "0" > $GTERM_RC

	fi
}



function CHECK_INSTALL()
{

	PKG="$(dpkg-query -W -f='${db:Status-Abbrev}' $1 2> /dev/null | cut -c 1-2)"

	if [ "$PKG" = "ii" ]; then

		echo "present"

	else

		echo "absent"

	fi

}

function APT_UPDATE()
{


	if [ "$UPDATE_RC" != "0" ]; then

		sudo apt-get update -qq
		UPDATE_RC="0"

	fi

}




function INSTALL()
{

	GIT_STATUS="$(CHECK_INSTALL git)"
	ANSIBLE_STATUS="$(CHECK_INSTALL ansible)"

	echo "Installing Essential Packages..."
	echo


	if [ "$ANSIBLE_STATUS" = "absent" ]; then

		sudo add-apt-repository -y ppa:ansible/ansible > /dev/null 2>&1 && APT_UPDATE
		sudo apt-get install -y software-properties-common ansible > /dev/null 2>&1
		echo ">> Ansible v$(ansible --version | head -1 | awk '{print $2}') installed."

	else

		echo ">> Ansible is already installed."

	fi


	if [ "$GIT_STATUS" = "absent" ]; then

		APT_UPDATE && sudo apt-get install -y git > /dev/null 2>&1
		echo ">> Git v$(git --version | awk '{print $3}') installed."

	else

		echo ">> Git is already installed."

	fi


	echo

}


function CLONE_REPO()
{
	REPO_DIR="/tmp/$$/vagabondv2"
	REPO_URL="https://github.com/rm-tic/vagabondv2.git"

	echo "Cloning Repository in $REPO_DIR"

	git clone $REPO_URL $REPO_DIR > /dev/null 2>&1

	echo
}


function EXEC_ANSIBLE()
{
	echo
	echo "Starting Playbook..."
	echo
	
	sudo ansible-playbook -i $REPO_DIR/hosts $REPO_DIR/main.yml
}


function MAIN()
{

echo
echo "+----------------------------------+"
echo "| Invencible                       |"
echo "| Author: Rodrigo Martins (IceTux) |"
echo "| Creation Date: 2020-03-30        |"
echo "+----------------------------------+"
echo
echo

#Exec Functions
GTERM_LOAD
INSTALL
CLONE_REPO
EXEC_ANSIBLE

}

MAIN
