FROM ibmcom/kitura-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Install Let's Encrypt (Base image uses Ubuntu 14.04)
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto

# Download repo
RUN git clone https://github.com/Andrew-Dunn/shorts-salad.git

# Checkout desired branch
ARG GIT_BRANCH=master
RUN cd shorts-salad && \
    git checkout $GIT_BRANCH && \
    cd ..

# Build webserver
RUN cd shorts-salad && \
    swift build && \
    cd ..

