FROM ibmcom/swift-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Load code
RUN mkdir shorts-salad
COPY . /root/shorts-salad

# Install Let's Encrypt (Base image uses Ubuntu 14.04)
RUN cd /root/shorts-salad/Scripts/ && \
    wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto && \
    cd /root/

# Build webserver
RUN cd /root/shorts-salad/ && \
    swift build && \
    cd /root/