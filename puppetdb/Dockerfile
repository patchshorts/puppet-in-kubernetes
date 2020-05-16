# Determines source "edge" or binary "release" builds
ARG build_type=edge
ARG UBUNTU_CODENAME=bionic

######################################################
# base
######################################################

FROM puppet/puppetdb:latest

ARG DUMB_INIT_VERSION="1.2.2"

ENV ANALYTICS_ENABLED=false \
    PUPPETDB_POSTGRES_HOSTNAME="postgres" \
    PUPPETDB_POSTGRES_PORT="5432" \
    PUPPETDB_POSTGRES_DATABASE="puppetdb" \
# NOTE: SSLDIR should never be set externally or it will break jetty.ini
    SSLDIR=/opt/puppetlabs/server/data/puppetdb/certs \
    LOGDIR=/opt/puppetlabs/server/data/puppetdb/logs \
    CERTNAME=puppetdb \
    DNS_ALT_NAMES="" \
    WAITFORCERT="" \
    PUPPETDB_USER=puppetdb \
    PUPPETDB_PASSWORD=puppetdb \
    PUPPETDB_NODE_TTL=7d \
    PUPPETDB_NODE_PURGE_TTL=14d \
    PUPPETDB_REPORT_TTL=14d \
    # used by entrypoint to determine if puppetserver should be contacted for config
    # set to false when container tests are run
    USE_PUPPETSERVER=true
# note: LOGDIR cannot be defined in the same ENV block it's used in
# this value may be set by users, keeping in mind that some of these values are mandatory
# -Djavax.net.debug=ssl may be particularly useful to set for debugging SSL
ENV PUPPETDB_JAVA_ARGS="-Djava.net.preferIPv4Stack=true -Xms256m -Xmx256m -XX:+UseParallelGC -Xlog:gc*:file=$LOGDIR/puppetdb_gc.log::filecount=16,filesize=65536 -Djdk.tls.ephemeralDHKeySize=2048"

LABEL org.label-schema.maintainer="Puppet Release Team <release@puppet.com>" \
      org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppetdb" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppetdb" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

# NOTE: this is just documentation on defaults
EXPOSE 8080 8081

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]

# The start-period is just a wild guess how long it takes PuppetDB to come
# up in the worst case. The other timing parameters are set so that it
# takes at most a minute to realize that PuppetDB has failed.
# Probe failure during --start-period will not be counted towards the maximum number of retries
# NOTE: k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --start-period=5m --interval=10s --timeout=10s --retries=6 CMD ["/healthcheck.sh"]

# hadolint ignore=DL3020
COPY shared/ssl.sh /
COPY shared/wtfc.sh /
ADD https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb \
    /docker-entrypoint.sh \
    /healthcheck.sh \
    /

COPY /docker-entrypoint.d /docker-entrypoint.d

# hadolint ignore=DL3009
RUN apt-get update && \
    apt-get install --no-install-recommends -y ca-certificates curl dnsutils netcat && \
    chmod +x /ssl.sh /wtfc.sh /docker-entrypoint.sh /healthcheck.sh && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_amd64.deb

COPY /Dockerfile /
