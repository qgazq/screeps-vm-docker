# screeps-vm-docker
This is just a setup readme, and is a work in progress.
It uses the screeps docker container provided by ags131 here https://github.com/ags131/docker-screeps-server
He also provided the docker compose outline, and wrote several of the screepsmod mods https://github.com/ScreepsMods/ that are used.

## Install VM
[VM Installation Instructions](installVM.md)

## Install docker images and configure
* Login as screeps
* `mkdir screeps`
* `cd screeps`
* clone this repo `git clone https://github.com/qgazq/screeps-vm-docker.git`
* copy in the docker-compose.yml from the repo `cp screeps-vm-docker/docker-compose.yml .`
* `sudo docker-compose up -d`  
* wait while the images are downloaded
* `sudo docker-compose down`
* wait while it stops  
[Running](screeps1.png)
* `sudo docker run -it --rm -v $PWD/data/server:/screeps quay.io/ags131/screeps-server init`
* wait while it build screeps
* Visit [https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey) and get an API Key
* Enter it into the prompt
* Don't try and type "screeps start" to launch your server! (well you can try but it won't work)
* `sudo docker run --rm -v $PWD/data/server:/screeps quay.io/ags131/screeps-server yarn add screepsmod-mongo screepsmod-auth screepsmod-tickrate screepsmod-admin-utils screepsmod-features screepsmod-gcltocpu screepsmod-history screepsmod-map-tool`

sudo vi data/server/mods.json  
add into mods array
```javascript
    "node_modules/screepsmod-map-tool/index.js",
    "node_modules/screepsmod-mongo/index.js",
    "node_modules/screepsmod-auth/index.js",
    "node_modules/screepsmod-tickrate/index.js",
    "node_modules/screepsmod-admin-utils/index.js",
    "node_modules/screepsmod-features/index.js",
    "node_modules/screepsmod-gcltocpu/index.js",
    "node_modules/screepsmod-history/index.js"
```

sudo vi data/server/.screepsrc  
at the end add
```
[mongo]
host = mongo

[redis]
host = redis

[history]
mode = 'file'

[maptool]
user = admin
pass = <your password here>
```

`sudo docker-compose up -d`

`sudo docker-compose exec server npx screeps cli`  
`system.resetAllData()`  
ctrl-c twice

`sudo docker-compose restart`

`ip -4 a`

Connect using steam, or connect to 
http://&lt;ip&gt;:21025/authmod/password/ and use steam to set a password then use grunt (etc) to upload code

profit?
