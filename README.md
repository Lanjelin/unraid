scripts and tinkering for unraid

--- 
  
  
  
# [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent#zsh-and-oh-my-zsh-with-persistent-history)

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, thus having bash as fallback.  

# [Autostart encrypted array using a second USB drive](https://github.com/Lanjelin/unraid/tree/main/usb-autostart-encrypted#autostart-encrypted-array-using-a-second-usb-drive)

A writeup of my replies to this [reddit thread](https://www.reddit.com/r/unRAID/comments/10rwfp9/ideas_for_a_wife_friendly_encrypted_array_startup/).  
Allows you to autostart the encrypted array so long as a second USB drive is plugged in at boot.
