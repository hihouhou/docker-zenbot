#
# Zenbot Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV ZENBOT_VERSION v4.1.1

# Update & install packages for fetching zenbot
RUN apt-get update && \
    apt-get install -y git curl gnupg2

#fetch last version of nodejs
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# Update & install packages for installing zenbot
RUN apt-get update && \
    apt-get install -y git nodejs node-gyp

# Install zenbot3
RUN git clone https://github.com/carlos8f/zenbot.git && \
    cd zenbot && \
    npm install --unsafe-perm && \
    npm link

#Configure Zenbot
COPY config.js /zenbot/config.js 
WORKDIR zenbot

EXPOSE 3013

CMD ["bash", "run.sh", "--verbose"]
