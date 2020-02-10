FROM gitlab/gitlab-runner:ubuntu

# Required dependencies
RUN apt-get update && \
  apt-get install vim -y && \
  apt-get install wget -y && \
  apt-get install lftp -y && \
  apt-get install gzip -y && \
  apt-get install sshpass -y

# NVM
# NVM environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 12.15.0

# NVM install
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# NODE versions install
RUN . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm install 8 \
  && nvm install 10 \
  && nvm alias default $NODE_VERSION \
  && nvm use default

# Add Paths for the commands
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Confirm node is installed
RUN node -v
RUN npm -v

RUN apt-get install yarn -y

# ANSIBLE install
RUN apt-get install python -y && \
  apt-get install ansible -y

# Set workdir to gitlab home user
WORKDIR /home/gitlab-runner

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--working-directory=/home/gitlab-runner"]