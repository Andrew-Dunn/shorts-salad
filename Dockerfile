FROM ibmcom/swift-ubuntu:latest
MAINTAINER Andrew Dunn <randy@🖕👖.ws>

# Install packages required by Let's Encrypt ahead-of-time.
RUN apt-get install -y --no-install-recommends python python-dev gcc && \
                                               libssl-dev openssl && \
                                               libffi-dev ca-certificates && \
                                               libaugeas0 augeas-lenses

# Load code.
RUN mkdir shorts-salad
COPY . /root/shorts-salad

# Install Let's Encrypt (Base image uses Ubuntu 14.04).
RUN cd /root/shorts-salad/Scripts/ && \
    wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto && \
    cd /root/

# Build web app in release configuration.
RUN cd /root/shorts-salad/ && \
    swift build -c release && \
    cd /root/

# Copy any config files that end in the .docker extension to be used.
RUN cd /root/shorts-salad/config/ && \
    find -name "*.docker" | cut -b 3- | xargs -L1 -i bash -c 'cp {} $(echo "{}" | rev | cut -d"." -f2- | rev)' && \
    cd /root/