FROM teemow/rpi-ubuntu:xenial

RUN echo "deb http://ports.ubuntu.com xenial main universe" > /etc/apt/sources.list
RUN echo "deb http://ports.ubuntu.com xenial-updates main universe" >> /etc/apt/sources.list
RUN echo "deb http://ports.ubuntu.com xenial-security main universe" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g vault-pki-client
RUN ln -s /usr/bin/nodejs /usr/bin/node

ENTRYPOINT vault-pki-client
CMD ["--help"]
