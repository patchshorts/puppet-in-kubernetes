FROM ubuntu:18.04

ARG PUPPET_AGENT_VERSION="5.5.7"
ENV R10K_VERSION="2.6.4" \
    DUMB_INIT_VERSION="1.2.2" \
    UBUNTU_CODENAME="bionic" \
    PUPPET_MODULE_CHORIA_VERSION="0.12.0" \
    PUPPET_MODULE_R10K_VERSION="7.0.0" \
    GWS_VERSION="0.2.0" \
    PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL org.label-schema.vendor="patchshorts" \
      org.label-schema.url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.name="Puppet r10k and Webhook" \
      org.label-schema.license="BSD-3-Clause" \
      org.label-schema.version=$PUPPET_SERVER_VERSION \
      org.label-schema.vcs-url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["deploy","environment","-pv" ]

COPY Dockerfile /

# TODO checksum check
RUN apt-get update && \
    apt-get install -y wget git netcat && \
    wget https://apt.puppetlabs.com/puppet5-release-"${UBUNTU_CODENAME}".deb && \
    wget https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    wget https://github.com/StreakyCobra/gws/releases/download/"${GWS_VERSION}"/gws-"${GWS_VERSION}" -O /usr/local/bin/gws && \
    chmod +x /usr/local/bin/gws && \
    dpkg -i puppet5-release-"${UBUNTU_CODENAME}".deb && \
    dpkg -i dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    rm puppet5-release-"${UBUNTU_CODENAME}".deb dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y r10k puppet-agent="${PUPPET_AGENT_VERSION}"-1"${UBUNTU_CODENAME}" && \
    gem install r10k --version "${R10K_VERSION}" --no-ri --no-rdoc && \
    gem install sinatra && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure .ssh directory
RUN mkdir /root/.ssh \
  && chmod 0600 /root/.ssh \
  && echo StrictHostKeyChecking no > /root/.ssh/config

# Add configuration file into the image
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
COPY webhook /usr/local/bin/
COPY webhook.yaml /etc/webhook.yaml
RUN chmod a+x /usr/local/bin/webhook
RUN mkdir -p /var/run/webhook /var/log/webhook
# Copy entrypoint into container
COPY docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/