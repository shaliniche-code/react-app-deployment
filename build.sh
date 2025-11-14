#!/bin/bash

#login into DockerHub:
docker login -u $DOCKER_USERNAME -p $DOCKER_PASS

#stopping existing container:
docker stop testcontainer || true
docker rm testcontainer   || true 

# Wait for Docker to fully release the port
sleep 5

# Hard cleanup for Jenkins (removes zombie containers)
docker ps -aq | xargs -r docker rm -f

#building a image:
docker build -t first_image .

#running a container from the created image:
docker run -d -it --name testphasecontainer -p 80:80 first_image

#pushing the image to dockerhub:
docker tag first_image shalinidocker12/testphasecontainer
docker push shalinidocker12/testphasecontainer
