# Autostart encrypted array using a second USB drive
A writeup of my replies to this [reddit thread](https://www.reddit.com/r/unRAID/comments/10rwfp9/ideas_for_a_wife_friendly_encrypted_array_startup/).  
Allows you to autostart the array so long as a second USB drive is plugged in at boot.  
This setup utilizes the UUID of the second drive to check if its inserted.  
Run `lsblk -f` to display UUID.
  
### The dead simple way
Store the encryption key in plain-text in the go-file on your unraid drive.  
Add the following to `/boot/config/go`
```bash
uuid=ED71-1D1D # <- replace with yours!
if lsblk -f | grep -wq $uuid; then
  echo -n "your-secret-key-here" > /root/keyfile
fi
```

### The safer way
Store the encryption key in plain-text in a keyfile on the second USB drive.  
Run `echo -n "your-secret-key-here" > keyfile` to make a keyfile.  
Add the following to `/boot/config/go`  
```bash
uuid=ED71-1D1D # <- replace with yours!
if lsblk -f | grep -wq $uuid; then
  mkdir /mnt/$uuid
  mount /dev/disk/by-uuid/$uuid /mnt/$uuid
  cp /mnt/$uuid/keyfile /root/keyfile
  umount /mnt/$uuid
  rm -r /mnt/$uuid
fi
```

### The safest way
Store the encryption key in a keyfile encrypted using openssl on the second USB drive.  
openssl (1.1.1s) is installed by default in unraid (6.11.5) it seems, check by typing `openssl help` in the terminal.  
Run `echo -n "your-secret-key-here" | openssl enc -aes-256-cbc -md sha512 -pbkdf2 -a -salt -pass pass:encryptionpassword > enckey` to make an encrypted keyfile.  
Add the following to `/boot/config/go`  
```
uuid=ED71-1D1D # <- replace with yours!
if lsblk -f | grep -wq $uuid; then
  mkdir /mnt/$uuid
  mount /dev/disk/by-uuid/$uuid /mnt/$uuid
  cat /mnt/$uuid/enckey | openssl enc -aes-256-cbc -md sha512 -pbkdf2 -a -d -salt -pass pass:encryptionpassword > /root/keyfile
  umount /mnt/$uuid
  rm -r /mnt/$uuid
fi
```
Change `encryptionpassword` to whatever you prefer. This is stored on the unraid drive, and used to decrypt the encrypted key on the second USB drive.
It could be moved to a third USB drive to make it even safer, though the safest is to always enter the key manually.

- - -

For added security, `/boot/keyfile` should be deleted after the array is started. 
One way to do this is by using the CA plugin [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/).
Adding the following to a script, setting it to `At First Array Start Only` should do the trick.
```bash
#!/bin/bash
rm /boot/keyfile
```
