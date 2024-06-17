# set environment variable
# export PASSWORD_DOCKER_HUB="rpl654321"

# create docker image from Dockerfile
docker build -t karsajobs-ui:latest .

# show docker images
docker images

# change image name
docker tag karsajobs-ui:latest arrizqydev/karsajobs-ui:latest

# login to docker hub
echo $PASSWORD_DOCKER_HUB | docker login -u arrizqydev --password-stdin

# push image to docker hub
docker push arrizqydev/karsajobs-ui:latest