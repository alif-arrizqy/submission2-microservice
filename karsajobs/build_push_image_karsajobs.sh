# set environment variable
# export PASSWORD_DOCKER_HUB="rpl654321"

# create docker image from Dockerfile
docker build -t karsajobs:latest .

# show docker images
docker images

# change image name
# docker tag karsajobs:latest arrizqydev/karsajobs:latest
docker tag karsajobs:latest ghcr.io/alif-arrizqy/karsajobs:latest

# login to docker hub
# echo $PASSWORD_DOCKER_HUB | docker login -u arrizqydev --password-stdin
echo $DOCKER_GHCR_PASSWORD | docker login ghcr.io -u alif-arrizqy --password-stdin


# push image to docker hub
# docker push arrizqydev/karsajobs:latest
docker push ghcr.io/alif-arrizqy/karsajobs:latest
