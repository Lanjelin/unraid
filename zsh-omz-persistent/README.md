# ZSH and oh-my-zsh with persistent history

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting zsh as default shell by having bash launch it if it exists - to avoid terminal from breaking should Nerdtools fail for any reason, thus having bash as fallback.  


Install ZSH using the [NerdTools](https://forums.unraid.net/topic/129200-plug-in-nerdtools/) CA Plugin.  
Install [Oh My ZSH](https://ohmyz.sh/) the regular way from the terminal  
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`


Run the following, line by line, to move all the files to the USB-drive, then symlinking them back to /root/
```bash
mkdir -p /boot/config/zsh
mv /root/.zshrc /boot/config/zsh/.zshrc 
mv /root/.oh-my-zsh /boot/config/zsh/.oh-my-zsh
ln -s /boot/config/zsh/.zshrc /root/.zshrc
ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh
rm /root/.zsh_history && ln -s /boot/config/zsh/.zsh_history /root/.zsh_history
echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile
```

Add the following to the bottom of your `/boot/config/go` to symlink at boot
```bash
# Launch zsh by default if its installed
echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile
# Link zsh + omz config, zsh history
ln -s /boot/config/zsh/.zshrc /root/.zshrc
ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh
ln -s /boot/config/zsh/.zsh_history /root/.zsh_history
```

If you're using tmux, add the following to your .zshrc to make it work properly with zsh  
```bash
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi
```

