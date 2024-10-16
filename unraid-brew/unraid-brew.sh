#!/bin/bash
# Where we store the actual bins -- should be on ssd/nvme
# Use drive directly, and not via /mnt/user/
# Makes a huge impact on performance
UNRAID_BREW_PATH=/mnt/services/appdata/linuxbrew
UNRAID_BASH=0
UNRAID_ZSH=0

_ub_install() {
	# Make the path if it doesn't exist
	mkdir -p "$UNRAID_BREW_PATH"

	# We want gcc -- unraid seems to already be shipped with procps curl file git
	if ! command -v gcc >/dev/null 2>&1; then
		echo "Installing gcc"
		if [ ! -f "$UNRAID_BREW_PATH"/gcc-14.2.0-x86_64-2.txz ]; then
			curl --output-dir "$UNRAID_BREW_PATH" -sO https://slackware.uk/slackware/slackware64-current/slackware64/d/gcc-14.2.0-x86_64-2.txz
		fi
		installpkg "$UNRAID_BREW_PATH"/gcc-14.2.0-x86_64-2.txz >/dev/null
	fi

	# Remove and relink home, instead of verifying everything
	rm /home/linuxbrew >/dev/null 2>&1
	ln -s "$UNRAID_BREW_PATH" /home/linuxbrew

	# brew doctor says we want this
	chmod 755 /usr/local/lib

	# Create the user if it doesn't exist
	if ! id linuxbrew >/dev/null 2>&1; then
		useradd --system --uid 95 --gid 100 --no-user-group --home-dir /home/linuxbrew linuxbrew
	fi

	# Install Homebrew if it doesn't exist
	if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
		cd /home/linuxbrew
		NONINTERACTIVE=1 su linuxbrew /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		cd - >/dev/null
	fi
}

_ub_remove() {
	userdel linuxbrew
	rm /home/linuxbrew
	rm -r "$UNRAID_BREW_PATH"
}

_ub_rc() {
	echo '' >>/root/"$1"
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/root/"$1"
	echo 'brew () {' >>/root/"$1"
	echo '  cd /home/linuxbrew' >>/root/"$1"
	echo '  su linuxbrew -s /home/linuxbrew/.linuxbrew/bin/brew -- "$@"' >>/root/"$1"
	echo '  cd - > /dev/null' >>/root/"$1"
	echo '}' >>/root/"$1"
}

_main() {
	if [ "$1" ]; then
		if [ "$1" == "rm" ] ||
			[ "$1" == "del" ] ||
			[ "$1" == "remove" ] ||
			[ "$1" == "delete" ] ||
			[ "$1" == "uninstall" ]; then
			_ub_remove
			echo "Done removing homebrew!"
			exit 0
		elif [ "$1" == "bash" ] ||
			[ "$1" == "zsh" ]; then
			if [ "$1" == "bash" ]; then
				UNRAID_BASH=1
			fi
			if [ "$1" == "zsh" ]; then
				UNRAID_ZSH=1
			fi
		else
			echo "Unsupported argument $1"
			exit 1
		fi
	fi

	_ub_install
	echo
	if [ "$UNRAID_BASH" == 1 ]; then
		_ub_rc ".bashrc"
		echo "Setting up .bashrc"
	fi
	if [ "$UNRAID_ZSH" == 1 ]; then
		_ub_rc ".zshrc"
		echo "Setting up .zshrc"
	fi
	if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
		echo "Homebrew is ready to use!"
		exit 0
	else
		echo "Something went wrong during installation."
		exit 1
	fi
}

_main "$@"
