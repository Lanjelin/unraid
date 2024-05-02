#!/bin/bash
# blacklist or whitelist mode
Mode="blacklist"
# List containers that should be checked here - mode whitelist
Whitelist=(
  container-name
)
# List containers that should be ignored here - mode blacklist
Blacklist=(
  container-name
)
# Don't edit below here unless you know what you're doing
Containers=$(docker ps -a --format "{{.Names}}")
for Container in $Containers; do
  Skip=false
  if [ $Mode == "whitelist" ]; then
    Skip=true
    for check in ${Whitelist[@]}; do
      if [ $Container == $check ]; then
        Skip=false
      fi
    done
  fi
  if [ $Mode == "blacklist" ]; then
    Skip=false
    for check in ${Blacklist[@]}; do
      if [ $Container == $check ]; then
        Skip=true
      fi
    done
  fi
  if [ $(docker container inspect -f '{{.State.Running}}' $Container) == "false" ] && [ $Skip == "false" ]; then
    docker container start $Container
    sleep 5
    if [ $(docker container inspect -f '{{.State.Running}}' $Container) == "false" ] && [ $Skip == "false" ]; then
      /usr/local/emhttp/plugins/dynamix/scripts/notify -e containerWatcher -s containerWatcher -d "$Container service is down, restart failed" -i "alert"
    else
      /usr/local/emhttp/plugins/dynamix/scripts/notify -e containerWatcher -s containerWatcher -d "$Container service is down, restart succeeded" -i "warning"
    fi
  fi
done
