#!/bin/bash

# Define Zookeeper servers
ZKINST=$(($ZK_INSTANCES))
if [[ ZKINST -gt 0 ]]; then
  for i in `seq 1 $ZKINST`; do
    ZK=$'ZK'$i$'_PORT_2181_TCP_ADDR'
    if [[ -z "$ZKADDR" ]]; then
      [[ ! -z "${!ZK}" ]] && ZKADDR=${!ZK}
    else
      [[ ! -z "${!ZK}" ]] && ZKADDR=$ZKADDR$','${!ZK}
    fi
  done
else
  ZKADDR=$ZK_PORT_2181_TCP_ADDR
fi

# Define Nimbus server
NIMBUS_IP=`hostname -i`
[[ ! -z "$NIMBUS_PORT_6627_TCP_ADDR" ]] && NIMBUS_IP=$NIMBUS_PORT_6627_TCP_ADDR

# Update Storm config file
sed -i -e "s/%zookeeper%/$ZKADDR/g" $STORM_HOME/conf/storm.yaml
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
