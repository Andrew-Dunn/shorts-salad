FROM ibmcom/kitura-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Install Let's Encrypt (Base image uses Ubuntu 14.04)
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto

# Download repo
ARG CHECKOUT=master
RUN git clone https://github.com/Andrew-Dunn/shorts-salad.git

# Checkout desired branch
RUN cd shorts-salad && \
    git checkout $CHECKOUT && \
    cd ..

# Build webserver
RUN cd shorts-salad && \
    swift build && \
    cd ..
