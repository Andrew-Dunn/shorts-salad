FROM ibmcom/kitura-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

RUN wget https://dl.eff.org/certbot-auto
RUN chmod a+x certbot-auto
