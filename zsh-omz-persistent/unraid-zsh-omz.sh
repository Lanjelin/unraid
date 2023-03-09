#!/bin/bash
#
# ZSH and oh-my-zsh with persistent history by github.com/Lanjelin
#
# This script is built for Unraid to use ZSH and oh-my-zsh with persistant history
# It moves settings and history to USB Flash Drive, symlinking them back to /root
#
# Prerequisites: 
#     zsh installed (using NerdTools CA Plugin)
#     oh-my-zsh installed https://ohmyz.sh/#install
#
echo
if [ ! -f /bin/zsh ]; then echo "zsh not installed!"; exit; fi
if [ ! -d /root/.oh-my-zsh ]; then echo "oh-my-zsh not installed!"; exit; fi
echo "Moving files to USB Drive"
mkdir -p /boot/config/zsh
mv /root/.zshrc /boot/config/zsh/.zshrc 
cp -RL /root/.oh-my-zsh /boot/config/zsh/.oh-my-zsh && rm -rf /root/.oh-my-zsh
ln -s /boot/config/zsh/.zshrc /root/.zshrc
ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh
cp /root/.zsh_history /boot/config/zsh/.zsh_history
rm /root/.zsh_history && ln -s /boot/config/zsh/.zsh_history /root/.zsh_history
echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile
echo 'if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi' >> /root/.zshrc
echo "Updating /boot/config/go"
echo '# Launch zsh by default if its installed' >> /boot/config/go
echo 'echo "if [ -f /bin/zsh ]; then /bin/zsh; exit; fi" >> /root/.bash_profile' >> /boot/config/go
echo '# Link zsh + omz config, zsh history' >> /boot/config/go
echo 'ln -s /boot/config/zsh/.zshrc /root/.zshrc' >> /boot/config/go
echo 'ln -s /boot/config/zsh/.oh-my-zsh /root/.oh-my-zsh' >> /boot/config/go
echo 'ln -s /boot/config/zsh/.zsh_history /root/.zsh_history' >> /boot/config/go
echo
echo "Done, relaunch terminal to use zsh"
