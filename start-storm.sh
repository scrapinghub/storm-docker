#!/bin/bash

# Define Nimbus server
NIMBUS_IP=`hostname -i`
[[ ! -z "$NIMBUS_PORT_6627_TCP_ADDR" ]] && NIMBUS_IP=$NIMBUS_PORT_6627_TCP_ADDR

# Update Storm config file
sed -i -e "s/%zookeeper%/$ZK_PORT_2181_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$NIMBUS_IP/g" $STORM_HOME/conf/storm.yaml

echo "storm.local.hostname: `hostname -i`" >> $STORM_HOME/conf/storm.yaml

# Update supervisord config depending on input
n=0
if [[ -z "$@" ]]
then
  /bin/bash
else
  for arg in "$@"; do
    case $arg in
      nimbus | drpc | supervisor | logviewer | ui )
        /usr/bin/config-supervisord.sh $arg
        n=$(( $n + 1 ))
        ;;
      * ) ;;
    esac
  done

  if [[ $n -gt 0 ]]; then
    supervisord -c /etc/supervisor/supervisord.conf
  else
    /bin/bash
  fi
fi
