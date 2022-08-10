# Container image that runs your code
FROM agrm/dactester:v1.4.1_amd

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
#ADD /tests /folderToTest

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
