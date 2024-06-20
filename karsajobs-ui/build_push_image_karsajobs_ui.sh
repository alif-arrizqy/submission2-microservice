# set environment variable
# export PASSWORD_DOCKER_HUB="rpl654321"

# create docker image from Dockerfile
docker build -t karsajobs-ui:latest .

# show docker images
docker images

# change image name
# docker tag karsajobs-ui:latest arrizqydev/karsajobs-ui:latest
docker tag karsajobs-ui:latest ghcr.io/alif-arrizqy/karsajobs-ui:latest

# login to docker hub
# echo $PASSWORD_DOCKER_HUB | docker login -u arrizqydev --password-stdin
echo $DOCKER_GHCR_PASSWORD | docker login ghcr.io -u alif-arrizqy --password-stdin


# push image to docker hub
# docker push arrizqydev/karsajobs-ui:latest
docker push ghcr.io/alif-arrizqy/karsajobs-ui:latest