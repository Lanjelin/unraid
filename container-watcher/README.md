# Container Watcher

Small bash script to be used with [user scripts](https://forums.unraid.net/topic/48286-plugin-ca-user-scripts/), to watch if containers are running.  
If a container is stopped, it will attempt to start it, and send a warning notification if succeeded, or an error if failed.

Set `Mode` to either `whitelist` or `blacklist`. Add the name of containers is respective list, one per line.

In `whitelist`-mode, it will check and restart containers only in this list.  
In `blacklist`-mode, it will check and restart all containers, except those in this list.
