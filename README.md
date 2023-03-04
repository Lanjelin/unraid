scripts and tinkering for unraid

--- 
  
  
  
# [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent)

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, thus having bash as fallback.  
