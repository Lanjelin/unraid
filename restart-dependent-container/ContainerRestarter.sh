#!/bin/bash
#
# ContainerRestarter
#  Restarts a specified container if another container is restarted, eg. by Watchtower
#  Set as user script, and to run at whatever desired interval, eg. */30 * * * * for every 30min
#  Notifications sent to GUI on successful/error restart of container
#
# User Input Start
CONTAINER_CHECK="python-webserver"
CONTAINER_RESTART="tor"
# User Input End
STARTED_CHECK=$(date --date "$(docker inspect -f '{{.State.StartedAt}}' $CONTAINER_CHECK)" +'%s')
STARTED_RESTART=$(date --date "$(docker inspect -f '{{.State.StartedAt}}' $CONTAINER_RESTART)" +'%s')
UPTIME=$(($(date +'%s')-$STARTED_CHECK))
TIMESTAMP() {
  echo $(date +"%d-%m-%Y %T")
}
if [ $STARTED_CHECK -ge $STARTED_RESTART ]
then
  echo "$(TIMESTAMP) $CONTAINER_CHECK started $((($UPTIME)/60)) minutes ago, restarting $CONTAINER_RESTART."
  if [ $(docker container restart $CONTAINER_RESTART) == $CONTAINER_RESTART ]
  then
    echo "$(TIMESTAMP) $CONTAINER_RESTART successfully restarted"
	/usr/local/emhttp/plugins/dynamix/scripts/notify -e ContainerRestarter -s ContainerRestarter -d "$CONTAINER_RESTART successfully restarted" -i "normal"
  else
    echo "$(TIMESTAMP) error while restarting $CONTAINER_RESTART"
	/usr/local/emhttp/plugins/dynamix/scripts/notify -e ContainerRestarter -s ContainerRestarter -d "Error while restarting $CONTAINER_RESTART" -i "alert"
  fi
else
  echo "$(TIMESTAMP) $CONTAINER_CHECK started $((($UPTIME)/60)) minutes ago, doing nothing."
fi
