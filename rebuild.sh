#!/bin/bash

# FIXME should be replaced with scrapinghub account
docker build -t="vshlapakov/storm" storm
docker build -t="vshlapakov/storm-nimbus" storm-nimbus
docker build -t="vshlapakov/storm-supervisor" storm-supervisor
docker build -t="vshlapakov/storm-ui" storm-ui
