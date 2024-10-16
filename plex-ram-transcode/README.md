# Plex Transcoding to RAM
Found in [this thread](https://forums.unraid.net/topic/35878-plex-guide-to-moving-transcoding-to-ram/page/9/#comment-760549) by digging the unraid forums.  
This utilizes the CA plugin [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/) to make a size-limited tmpfs for plex to transcode to.  
Could probably be done using the go-file as well.

Add a new userscript, set to run `At First Array Start Only`
```bash
#!/bin/bash
mkdir -p /tmp/PlexRamScratch
chmod -R 777 /tmp/PlexRamScratch
mount -t tmpfs -o size=4g tmpfs /tmp/PlexRamScratch
```

In Plex Docker Container settings, add a Path:
 - Name: tmpfs / ram transcode
 - Container Path: /transcode
 - Host Path: /tmp/PlexRamScratch
 - Access Mode: Read/Write

Finally ensure plex itself is using the correct path;  
Settings -> Transcoder -> Transcoder temporary directory should be `/transcode`
