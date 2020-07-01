#
# Zenbot Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV ZENBOT_VERSION v4.1.2

# Update & install packages for fetching zenbot
RUN apt-get update && \
    apt-get install -y git wget curl gnupg2

#fetch last version of nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Update & install packages for installing zenbot
RUN apt-get update && \
    apt-get install -y git nodejs make gcc g++

# Install zenbot3
RUN mkdir zenbot && \
    cd zenbot && \
    wget https://api.github.com/repos/carlos8f/zenbot/tarball/${ZENBOT_VERSION} -O ${ZENBOT_VERSION}.tar.gz && \
    tar xf  ${ZENBOT_VERSION}.tar.gz --strip-components=1 && \
    npm install --unsafe-perm && \
    npm link

#Configure Zenbot
COPY config.js /zenbot/config.js 
WORKDIR zenbot

EXPOSE 3013

CMD ["bash", "run.sh", "--verbose"]
