FROM ibmcom/kitura-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Install OpenSSL
RUN apt-get install openssl libssl-dev

# Install Let's Encrypt (Base image uses Ubuntu 14.04)
RUN wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto
