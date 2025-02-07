<p align="center">scripts and tinkering for unraid</p>
<p align="center">a place where I dump stuff I've written for <a href="https://unraid.net/">UnRaid</a></p>
  
--- 
  
  
## Scripts

### [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent#zsh-and-oh-my-zsh-with-persistent-history)

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, having bash as fallback.

### [Homebrew on Unraid](https://github.com/Lanjelin/unraid/tree/main/unraid-brew)

A way to install [Homebrew](https://brew.sh/) - The Missing Package Manager for macOS (or Linux) on Unraid.  
Guide to install everything, and have it persist through reboots.

### [Unraid Fetch](https://github.com/Lanjelin/unraid/tree/main/unraid-fetch)

Unraid logo ascii files for Neofetch and Fastfetch.

### [Autostart encrypted array using a second USB drive](https://github.com/Lanjelin/unraid/tree/main/usb-autostart-encrypted#autostart-encrypted-array-using-a-second-usb-drive)

A writeup of my replies to this [reddit thread](https://www.reddit.com/r/unRAID/comments/10rwfp9/ideas_for_a_wife_friendly_encrypted_array_startup/).  
Allows you to autostart the encrypted array so long as a second USB drive is plugged in at boot.

### [Plex Transcoding to RAM](https://github.com/Lanjelin/unraid/tree/main/plex-ram-transcode#plex-transcoding-to-ram)

Save your drives, let Plex use a (limited) part of your ram as cache when transcoding.  
Found in [this thread](https://forums.unraid.net/topic/35878-plex-guide-to-moving-transcoding-to-ram/page/9/#comment-760549) by digging the unraid forums.

### [Container Watcher](https://github.com/Lanjelin/unraid/tree/main/container-watcher)

Small bash script to be used with [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/), to watch if containers are running.  
If a container is stopped, it will attempt to start it, and send a warning notification if succeeded, or an error if failed.

### [Container Restarter](https://github.com/Lanjelin/unraid/tree/main/restart-dependent-container)

Restarts a specified container if another container is restarted, eg. by Watchtower using the CA plugin [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/)

## Packages

### [unraid_vm_icons](https://github.com/Lanjelin/unraid_vm_icons)

A fork of [SpaceinvaderOne](https://github.com/SpaceinvaderOne/unraid_vm_icons)s excellent Docker Container for adding VM icons to the Unraid VM Manager.  
I wanted to go with a different approach, as I want as little as possible clutter among my containers.  
All the icons have been compiled into a Slackware Package, that unRaid can install on boot.  
This will install all the included icons, but not touch the original ones.

## Containers

### [slackbuilder](https://github.com/Lanjelin/slackbuilder)

A Docker image for building packages for slackware 15 / unraid.

### [nvim-docker](https://github.com/Lanjelin/nvim-docker)

Run [NeoVim](https://neovim.io/) using docker, directly in the terminal, or in your favourite browser using the included [nerd-patched ttyd](https://github.com/Lanjelin/nerd-ttyd).  
Image built on [Arch Linux](https://hub.docker.com/_/archlinux), includes several popular nvim distros.

### [AstroNvim Docker](https://github.com/Lanjelin/astronvim-docker)

Deprecated really, use the above nvim-docker.
