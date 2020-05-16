
ARG UBUNTU_CODENAME=bionic

######################################################
# base
######################################################

FROM puppet/puppetserver:latest

ARG PACKAGES=ca-certificates\ git
ARG DUMB_INIT_VERSION="1.2.2"

LABEL org.label-schema.maintainer="Puppet Release Team <release@puppet.com>" \
      org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppetserver" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppetserver" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

ENV PUPPERWARE_ANALYTICS_TRACKING_ID="UA-132486246-4" \
    PUPPERWARE_ANALYTICS_APP_NAME="puppetserver" \
    PUPPERWARE_ANALYTICS_ENABLED=false \
    PUPPETSERVER_JAVA_ARGS="-Xms512m -Xmx512m" \
    PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH \
    SSLDIR=/etc/puppetlabs/puppet/ssl \
    LOGDIR=/var/log/puppetlabs/puppetserver \
    PUPPETSERVER_HOSTNAME="" \
    DNS_ALT_NAMES="" \
    PUPPET_MASTERPORT=8140 \
    AUTOSIGN="" \
    PUPPETSERVER_MAX_ACTIVE_INSTANCES=1 \
    PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE=0 \
    CA_ENABLED=true \
    CA_HOSTNAME=puppet \
    CA_MASTERPORT=8140 \
    CA_ALLOW_SUBJECT_ALT_NAMES=true \
    USE_PUPPETDB=true \
    PUPPETDB_SERVER_URLS=https://puppetdb:8081 \
    PUPPET_STORECONFIGS_BACKEND="puppetdb" \
    PUPPET_STORECONFIGS=true \
    PUPPET_REPORTS="puppetdb" \
    HIERA_BASE64="your base64 encoded hiera.yaml file" \
    EYAML_PUBLIC_BASE64="your encoded pcks7 pub key pem contents" \
    EYAML_PRIVATE_BASE64="your encoded pcsk7 private key pem contents" \
    UBUNTU_CODENAME=bionic

# NOTE: this is just documentation on defaults
EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]

# ADD https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb /

COPY docker-entrypoint.sh \
     healthcheck.sh \
     /
COPY docker-entrypoint.d/* /docker-entrypoint.d/
# k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=15s --retries=12 --start-period=3m CMD ["/healthcheck.sh"]

# no need to pin versions or clear apt cache as its still being used
# hadolint ignore=DL3008,DL3009
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh /docker-entrypoint.d/*.sh || true

COPY Dockerfile /
