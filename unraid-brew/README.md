# Homebrew on Unraid

This is a way to install and run [Homebrew](https://brew.sh/) -- The Missing Package Manager for macOS (or Linux) on [Unraid](https://unraid.net/).

## How To:

### Install

Edit the `UNRAID_BREW_PATH` variable with a fitting location on your setup. For performance reasons, it should point directly to a drive (ssd/nvme pref) instead of the regular `/mnt/user`-path.  
Edit the `UNRAID_BASH` or `UNRAID_ZSH` variable, or run the script with either `bash` or `zsh` as argument, to make the script update `.bashrc` or `.zshrc`.  
After that, it's as simple as running the script.

### Usage

Copy the entire content of `unraid-brew.sh` in to a [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/)-script, and set it to run `At First Array Start Only`.

Due to unraids root-by-default an additional function is needed to run homebrew as non-root.

Either:

- Set the variable `UNRAID_BASH` and/or `UNRAID_ZSH` to `1` to make the script update `.bashrc` and/or `.zshrc`.

- If you've followed my guide for [ZSH and oh-my-zsh with persistent history](https://github.com/Lanjelin/unraid/tree/main/zsh-omz-persistent#zsh-and-oh-my-zsh-with-persistent-history),
  add the following to your `.zshrc` and do a `source ~/.zshrc`, and everything should be ready to use.

```bash
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew () {
    cd /home/linuxbrew
    su linuxbrew -s /home/linuxbrew/.linuxbrew/bin/brew -- "$@"
    cd - > /dev/null
  }
fi
```

### Uninstall

Re-run the script with the argument `remove` to remove everything except the script itself.
