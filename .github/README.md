
<p align="center">scripts and tinkering for unraid</p>
<p align="center">a place where I dump stuff I've written for <a href="https://unraid.net/">UnRaid</a></p>
  
--- 
  
  
## Scripts

#### [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent#zsh-and-oh-my-zsh-with-persistent-history)

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, having bash as fallback.  


### [Autostart encrypted array using a second USB drive](https://github.com/Lanjelin/unraid/tree/main/usb-autostart-encrypted#autostart-encrypted-array-using-a-second-usb-drive)

A writeup of my replies to this [reddit thread](https://www.reddit.com/r/unRAID/comments/10rwfp9/ideas_for_a_wife_friendly_encrypted_array_startup/).  
Allows you to autostart the encrypted array so long as a second USB drive is plugged in at boot.


### [Plex Transcoding to RAM](https://github.com/Lanjelin/unraid/tree/main/plex-ram-transcode#plex-transcoding-to-ram)

Save your drives, let Plex use a (limited) part of your ram as cache when transcoding.  
Found in [this thread](https://forums.unraid.net/topic/35878-plex-guide-to-moving-transcoding-to-ram/page/9/#comment-760549) by digging the unraid forums. 

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

### [AstroNvim Docker](https://github.com/Lanjelin/astronvim-docker)

Run [AstroNvim](https://astronvim.com/) using docker, directly in your terminal, or in your favourite browser using the included [ttyd](https://github.com/tsl0922/ttyd).  
Image built on [Alpine Linux](https://hub.docker.com/_/alpine), it inlcudes AstroNvim with [default user settings](https://github.com/AstroNvim/user_example), zsh with [oh-my-zsh](https://ohmyz.sh/), and ttyd. 
