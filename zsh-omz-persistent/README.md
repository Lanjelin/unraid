# ZSH and oh-my-zsh with persistent history

Moving .zshrc to flash-drive, symlinking it back to root.  
Moving history (.zsh_history) and oh-my-zsh (.oh-my-zsh) to the array (default path /mnt/user/appdata/zsh/, and configuring .zshrc to use these paths.  
Setting bash to seamlessly launch zsh if it exists, and array is started - to avoid terminal from breaking if not all files are mounted (bash as fallback terminal).  

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
mv /root/.zshrc /boot/config/.zshrc
ln -s /boot/config/.zshrc /root/.zshrc
mkdir -p /mnt/user/appdata/zsh
cp -r /root/.oh-my-zsh /mnt/user/appdata/zsh/.oh-my-zsh" && rm -rf /root/.oh-my-zsh
echo "export HISTFILE=/mnt/user/appdata/zsh/.zsh_history" >> /boot/config/.zshrc
sed -i -e "s|\$HOME/.oh-my-zsh|/mnt/user/appdata/zsh/.oh-my-zsh|" /boot/config/.zshrc 
mv /root/.zsh_history /mnt/user/appdata/zsh/.zsh_history
echo 'if [ -d /mnt/user/appdata/zsh/.oh-my-zsh ]; then ( if [ -f /bin/zsh ]; then /bin/zsh; exit; fi ) fi' >> /root/.bash_profile
```

Now restart your terminal session, it should now launch zsh.  
If everything looks fine, add the following to the bottom of your `/boot/config/go` to symlink at boot
```bash
# Launch zsh by default if its installed, and .oh-my-zsh is available
echo 'if [ -d /mnt/user/appdata/zsh/.oh-my-zsh ]; then ( if [ -f /bin/zsh ]; then /bin/zsh; exit; fi ) fi' >> /root/.bash_profile
# Linking .zshrc to ~/.zshrc
ln -s /boot/config/.zshrc /root/.zshrc
```

If you're using tmux, add the following to your .zshrc to make it work properly with zsh  
```bash
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi
```

### Files this script changes (if you want to remove)
 - /boot/config/go
 - /root/.bash_profile
 - obviously /root/.oh-my-zsh is moved
 - .zshrc is moved, and the line containing `HISTFILE` is added, and `export ZSH=$HOME/.oh-my-zsh`is changed
