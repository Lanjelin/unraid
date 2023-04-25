scripts and tinkering for unraid

--- 
  
  
  
# [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent#zsh-and-oh-my-zsh-with-persistent-history)

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, having bash as fallback.  


# [Autostart encrypted array using a second USB drive](https://github.com/Lanjelin/unraid/tree/main/usb-autostart-encrypted#autostart-encrypted-array-using-a-second-usb-drive)

A writeup of my replies to this [reddit thread](https://www.reddit.com/r/unRAID/comments/10rwfp9/ideas_for_a_wife_friendly_encrypted_array_startup/).  
Allows you to autostart the encrypted array so long as a second USB drive is plugged in at boot.


# [Plex Transcoding to RAM](https://github.com/Lanjelin/unraid/tree/main/plex-ram-transcode#plex-transcoding-to-ram)

Save your drives, let Plex use a (limited) part of your ram as cache when transcoding.  
Found in [this thread](https://forums.unraid.net/topic/35878-plex-guide-to-moving-transcoding-to-ram/page/9/#comment-760549) by digging the unraid forums. 

# [Container Restarter](https://github.com/Lanjelin/unraid/tree/main/restart-dependent-container)
Restarts a specified container if another container is restarted, eg. by Watchtower using the CA plugin [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/)
