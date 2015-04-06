#!/bin/bash

# Define Nimbus server
NIMBUS_IP="172.17.42.1"
[[ ! -z "$NIMBUS_PORT_6628_TCP_ADDR" ]] && NIMBUS_IP=$NIMBUS_PORT_6628_TCP_ADDR
NIMBUS_PORT=6628
[[ ! -z "$NIMBUS_PORT_6628_TCP_PORT" ]] && NIMBUS_PORT=$NIMBUS_PORT_6628_TCP_PORT

# Define DRPC ports
DRPC_PORT=3774
[[ ! -z "$DRPC_PORT_3774_TCP_PORT" ]] && DRPC_PORT=$DRPC_PORT_3774_TCP_PORT
DRPC_INVOCATIONS_PORT=3775
[[ ! -z "$DRPC_INVOCATIONS_PORT_3775_TCP_PORT" ]] && DRPC_INVOCATIONS_PORT=$DRPC_INVOCATIONS_PORT_3775_TCP_PORT

# Update Storm config file
sed -i -e "s/%zookeeper%/$ZK_PORT_2181_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$NIMBUS_IP/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus-port%/$NIMBUS_PORT/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%drpc-port%/$DRPC_PORT/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%drpc-invocations-port%/$DRPC_INVOCATIONS_PORT/g" $STORM_HOME/conf/storm.yaml


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
