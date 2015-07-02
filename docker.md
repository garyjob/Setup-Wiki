# Ubuntu Trusty 14.04 
### Installation and setup

``` Console
sudo apt-get update
sudo apt-get install docker.io
```

# Mac OS X

### Installation and setup
Install Boot2Docker which you will download from this URL
https://github.com/boot2docker/osx-installer/releases/tag/v1.5.0

Update your ~/.bashrc file with the following entries
```console
# Docker 
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/garyjob/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
```

Startup Boot2Docker
```console
boot2docker up
```

checking the ip address of your boot2docker 
```
boot2docker ip
```

Docker run in daemonized mode
```
docker run -d CONTAINER_IMAGE
```

With the IP address and the port you could access the services sitting on a port 
in that container

### Using of Dockerfile
In your project repository

```console
touch Dockerfile
```

The following line in the Dockerfile will kick start a process
When the process ends, the docker container stops.
```console
CMD [ "phantomjs", "/root/krake_phantomjs/server.js" ]
```

Make sure the CMD does not only call bin/bash, because that will end within 4 seconds
You can check by running the following command
```console
docker ps # check the COMMAND column
```

To create an image from the docker file run the following command in the same directory as the docker file
```console
docker build -t my_image_name .
```

-t flag is for the image_name

To spin up a container from the image created using the docker file
```console
docker run -p 9701:9701 -v /Users/garyjob/Applications/krake_phantom/:/root/krake_phantomjs -d mbp
```

-p : specifies the port mapping from the host to the container
-v : specifies the local folder to map to a folder in the container

It is best to map the following code repository folder to a folder in the container,
this ensures only the latest code is ran.