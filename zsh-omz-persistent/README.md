# ZSH and oh-my-zsh with persistent history

Installing everything, moving settings (.zshrc), history (.zsh_history), and oh-my-zsh (.oh-my-zsh) to the USB-drive, and symlinking them back to /root/.  
Setting bash to seamlessly launch zsh if it exists - to avoid terminal from breaking should Nerdtools fail for any reason (bash as fallback terminal).  

Caution: omz update will fail on FAT32-formatted drives due to a symlinked theme and plugin.

Install ZSH using the [NerdTools](https://forums.unraid.net/topic/129200-plug-in-nerdtools/) CA Plugin.  
Install [Oh My ZSH](https://ohmyz.sh/) the regular way from the terminal  
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```  
**Do not set zsh as default shell!**

###  Auto install
Run the following all-in-on script, _or_ follow the guide below
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Lanjelin/unraid/main/zsh-omz-persistent/unraid-zsh-omz.sh)"
```
  
### Manual install
Run the following, line by line, to move all the files to the USB-drive, then symlinking them back to /root/
```bash
mkdir -p /boot/config/zsh
mv /root/.zshrc /boot/config/zsh/.zshrc 
cp -RL /root/.oh-my-zsh /boot/config/zsh/.oh-my-zsh && rm -rf /root/.oh-my-zsh
ln -s /boot/config/zsh/.zshrc /root/.zshrc
ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh
cp /root/.zsh_history /boot/config/zsh/.zsh_history
rm -f /root/.zsh_history && ln -s /boot/config/zsh/.zsh_history /root/.zsh_history
echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile
```

Now restart your terminal session, it should now launch zsh.  
If everything looks fine, add the following to the bottom of your `/boot/config/go` to symlink at boot
```bash
# Launch zsh by default if its installed
echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile
# Link zsh + omz config, zsh history
ln -s /boot/config/zsh/.zshrc /root/.zshrc
ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh
rm -f /root/.zsh_history && ln -s /boot/config/zsh/.zsh_history /root/.zsh_history
```

If you're using tmux, add the following to your .zshrc to make it work properly with zsh  
```bash
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi
```

