# Create a vault-pki-client container for the Raspberry Pi

There is no binary release for arm of the vault-pki-client. So we have to install nodejs in a container.

Download the image:

```
docker pull teemow/rpi-vault-pki-client
```

Create your own image

```
docker build -t rpi-pki-client .
```

# Run

```
/usr/bin/docker run --rm --name=vault-pki-client --net=host \
    -v /var/run/dbus:/var/run/dbus \
    -v /usr/local/share/ca-certificates:/ca \
    -v /etc/certificates:/etc/certificates \
    -v /usr/local/bin/cert-update:/usr/local/bin/cert-update \
    --entrypoint=vault-pki-client \
    teemow/rpi-vault-pki-client \
    --vault.server.address=https://vault.bar.com:8200 \
    --vault.server.ca-path=/ca \
    --vault.token=my-foo-bar-token \
    --vault.token-renewable=true \
    --vault.pki.path=pki \
    --vault.pki.role=foo.bar.com \
    --certFile=/etc/certificates/foo.bar.com.crt \
    --keyFile=/etc/certificates/foo.bar.com.key \
    --caFile=/etc/certificates/foo.bar.com.ca \
    --certCN=foo.bar.com \
    --certTTL=72h \
    --onUpdate=/usr/local/bin/cert-update
```

Also see: https://github.com/teemow/docker-rpi-ubuntu
