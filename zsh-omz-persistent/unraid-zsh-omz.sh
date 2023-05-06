#!/bin/bash
#
# ZSH and oh-my-zsh with persistent history by github.com/Lanjelin
#
# This script is built for Unraid to use ZSH and oh-my-zsh with persistant history
# It moves settings USB Flash Drive, and omz along with history to /mnt/user/appdata/zsh
#
# Prerequisites: 
#     zsh installed (using NerdTools CA Plugin)
#     oh-my-zsh installed https://ohmyz.sh/#install
#
echo
if [ ! -f /bin/zsh ]; then echo "zsh not installed!"; exit; fi
if [ ! -d /root/.oh-my-zsh ]; then echo "oh-my-zsh not installed!"; exit; fi
OMZPATH="/mnt/user/appdata/zsh"
echo "Please enter path to store omz and history (leave blank to use $OMZPATH):"
read directory
if [ -n "$directory" ]; then
  echo "Confirm $directory? (y/n)"
  read answer
  if [[ "$answer" =~ ^[yY]$ ]]; then
    OMZPATH=$directory
    exit 0
  else
  	exit 0
  fi
fi
echo
echo "Moving .zshrc to USB Drive"
mv /root/.zshrc /boot/config/.zshrc
ln -s /boot/config/.zshrc /root/.zshrc
echo "Moving .oh-my-zsh to $OMZPATH"
mkdir -p $OMZPATH
cp -r /root/.oh-my-zsh $OMZPATH"/.oh-my-zsh" && rm -rf /root/.oh-my-zsh
echo "Updating .zshrc with new paths - history-file moved to $OMZPATH/.zsh_history"
echo "export HISTFILE=$OMZPATH/.zsh_history" >> /boot/config/.zshrc
sed -i -e "s|\$HOME/.oh-my-zsh|${OMZPATH}/.oh-my-zsh|" /boot/config/.zshrc 
if [ -f /root/.zsh_history ]; then mv /root/.zsh_history $OMZPATH/.zsh_history; fi
echo "Updating .bash_profile"
echo "if [ -d $OMZPATH/.oh-my-zsh ]; then ( if [ -f /bin/zsh ]; then /bin/zsh; exit; fi ) fi" >> /root/.bash_profile
echo 'if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi' >> /root/.zshrc
echo "Updating /boot/config/go"
echo '# Launch zsh by default if its installed, and .oh-my-zsh is available' >> /boot/config/go
echo "echo \"if [ -d $OMZPATH/.oh-my-zsh ]; then ( if [ -f /bin/zsh ]; then /bin/zsh; exit; fi ) fi\" >> /root/.bash_profile" >> /boot/config/go
echo '# Linking .zshrc to ~/.zshrc' >> /boot/config/go
echo 'ln -s /boot/config/.zshrc /root/.zshrc' >> /boot/config/go
echo
echo "Done, relaunch terminal to use the updated zsh"
