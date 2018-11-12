#!/bin/bash

DIR=$(dirname $0)

cp $DIR/docker-compose.yml .
sudo docker-compose up -d 
sudo docker-compose down
sudo docker run -it --rm -v $PWD/data/server:/screeps quay.io/ags131/screeps-server init
sudo docker run --rm -v $PWD/data/server:/screeps quay.io/ags131/screeps-server yarn add screepsmod-mongo screepsmod-auth screepsmod-tickrate screepsmod-admin-utils screepsmod-features screepsmod-gcltocpu screepsmod-history screepsmod-map-tool
sudo cp $DIR/mods.json data/server/mods.json  

read -r -p "Enter a password for maptool: " MAPPASSWD

cp data/server/.screepsrc $PWD

cat >> $PWD/.screepsrc << ENDHEREDOC

[mongo]
host = mongo

[redis]
host = redis

[history]
mode = 'file'

[maptool]
user = admin
pass = $MAPPASSWD

ENDHEREDOC

sudo cp $PWD/.screepsrc data/server/

sudo docker-compose up -d

sudo docker-compose exec server npx screeps cli
#system.resetAllData()
#ctrl-c twice

sudo docker-compose restart

ip -4 a | grep enp | grep inet


