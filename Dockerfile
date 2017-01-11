FROM ibmcom/kitura-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Install Let's Encrypt (Base image uses Ubuntu 14.04)
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto

# Load code
RUN mkdir shorts-salad
COPY . /root/shorts-salad

# Build webserver
RUN cd /root/shorts-salad/ && \
    swift build && \
    cd /root/
