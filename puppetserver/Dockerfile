
ARG UBUNTU_CODENAME=bionic

######################################################
# base
######################################################

FROM puppet/puppetserver:latest

ARG PACKAGES=ca-certificates\ git
ARG DUMB_INIT_VERSION="1.2.2"

LABEL org.label-schema.maintainer="Chris Godwin <patchshorts@gmail.com>" \
      org.label-schema.vendor="Puppet In Kubernetes" \
      org.label-schema.url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile" \
      org.label-schema.name="Puppetserver"

ENV ANALYTICS_TRACKING_ID="UA-132486246-4" \
    ANALYTICS_APP_NAME="puppetserver" \
    ANALYTICS_ENABLED=false \
    PUPPETSERVER_JAVA_ARGS="-Xms512m -Xmx512m" \
    PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH \
    SSLDIR=/etc/puppetlabs/puppet/ssl \
    LOGDIR=/var/log/puppetlabs/puppetserver \
    PUPPETSERVER_HOSTNAME="" \
    DNS_ALT_NAMES="puppet.local" \
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
    HIERA_BASE64="" \
    EYAML_PUBLIC_BASE64="LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMyVENDQWNHZ0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRVUZBREFBTUNBWERUSXdNRFV4TmpBM01UWXkKTUZvWUR6SXdOekF3TlRBME1EY3hOakl3V2pBQU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQgpDZ0tDQVFFQTFIUUVTN2xZTEFPNkdlV3ZFNk83UEw3RTJjckJaemtmZnpod1o2SlBpMnVlWGZQdlFnaUkvL1VjCkRXK3hvOWxZem41UG5JeTZ2eCtmNUZKMTc1bnFPNHVLaE1sMXFRVmRBNzNRS21qWDM4eFFPeGlkZ1hBc0xqVTEKUTJHV1JaMVR0bjRIM2Zacll4QzlGRmJ5ZXdPL095TnZTbDNHODgydnpZbDdWVUdpSUs1bVFRNDlpdWQxYm1TTwp4NWt0dmFyQk5wdjhBRDZISnlWc2FqVTFBd2d4TDltb0Y4NHZTQ3dJMFYwRlFpeng1RnBtbmZ3R040dU56Q09RClIxSGZZVXEvUG50RzROeGxOcVBVdVc5dmp3bmZvRXZTVW95aVUwQ0Y5Y05hVW1scWhJeEFiakN0Z0RaeGV4N0EKRjkwTll3WEVKVm9sUmZnZGszeG8vN1l5eVBMbTdRSURBUUFCbzF3d1dqQVBCZ05WSFJNQkFmOEVCVEFEQVFILwpNQjBHQTFVZERnUVdCQlE3TW8rRXdpcWVWc29yaktwelBNT2p5MnlTY0RBb0JnTlZIU01FSVRBZmdCUTdNbytFCndpcWVWc29yaktwelBNT2p5MnlTY0tFRXBBSXdBSUlCQVRBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWRrNTAKZTVaclVNZjhSdU5sbW11UzF0NHZFMVhwT1VKNUVVMTlsbFphcDZFNXIyU3prM0lsRDdsTmx0ampjSXY4cE1Vdwp6MEFHazVlSjNGM2lkbTludGZZR1RoVnBSdUNEbGU0SEdra2ZFdUlIMk15S1IxZG0xWWtUV2VPTWlRTnlTVWVUCnJpdVVjV0MrV2c1L1gxa09lM0hKaHFkL25iWDFnN2ZYSFQvYlNjY2VKV3FpdUdKaDNvOWIzZzdUeSs1cDNLdzYKZUx1RStGVXRoTjE4UW9JeG5RYnU5bjB1aTU3YXBVNUpDQUFtUXZrZytBdnY2UjU5OVk4ckdjQTJlaGRRSnIyZwpHZTZjQ2lVbU9OU3lXbU4xM3ZvT1F6ci9kanl4bkZ4NHNwM0k5K0RrUTYyb3ZDWXZnZmwzZUtuSUZzQlJON3dnCk1yT0N3SktEQjc0NmJaV0thQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K" \
    EYAML_PRIVATE_BASE64="LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBMUhRRVM3bFlMQU82R2VXdkU2TzdQTDdFMmNyQlp6a2Zmemh3WjZKUGkydWVYZlB2ClFnaUkvL1VjRFcreG85bFl6bjVQbkl5NnZ4K2Y1RkoxNzVucU80dUtoTWwxcVFWZEE3M1FLbWpYMzh4UU94aWQKZ1hBc0xqVTFRMkdXUloxVHRuNEgzZlpyWXhDOUZGYnlld08vT3lOdlNsM0c4ODJ2ellsN1ZVR2lJSzVtUVE0OQppdWQxYm1TT3g1a3R2YXJCTnB2OEFENkhKeVZzYWpVMUF3Z3hMOW1vRjg0dlNDd0kwVjBGUWl6eDVGcG1uZndHCk40dU56Q09RUjFIZllVcS9QbnRHNE54bE5xUFV1Vzl2anduZm9FdlNVb3lpVTBDRjljTmFVbWxxaEl4QWJqQ3QKZ0RaeGV4N0FGOTBOWXdYRUpWb2xSZmdkazN4by83WXl5UExtN1FJREFRQUJBb0lCQUZSbEtmZXl6dlhkSFNhQQplVVlCK3JVc3l5SUJTMGJvQ0QwUGZJZU9rSzYvdDQ5M0FZcG52WlNBRi82MmFnaStwR3FTL3FrZnRtZUo5b2hLCndaTEd2NmVielJEbXZwakFDcTBiei8rbzJtaUt6eXhLb1BiMFNuaW9wbG40QUN2elRYZm5KTlRsdU04SHJUVFIKUFUza3RTaVc4UFRIdityRndKcVRqS3pYZjhJZkM4SVg1dkY2UXNTVlc5d05oRjBjSDk0eEdOL0NMeXErMTlLWQpETHV1N0hHRGlUYnNqOHNKdUl3UzkrUjJQaUNPZGsvOGtDekRhUUx3TEJ5S0xzSVFxZGxyV1Q4eWRHd3lrSlBvCng5U01hVFY0d2FnNVo3dDJQbk5yQ0VjK1p6ZHREVDRubGpwTzc1NFdZMzdWb2dsRHBpT3A1WVZoazNGa05BbU8KNmorSWJ6a0NnWUVBK2RTWDlMbVJra3ozQVMxSFppQTlBd3lNVmg1T1YxbVgwUVRhN0srU0tyc3NDZHB3bkdYdgorYzQ5N3ZmRWJId29IYWliT0ZGM2dHcFJRRnlSeU5hd1FlOHVTTXIvWU4vS1o2aThUdXY2S252RHZCYVRNZm9HCkZBYTB4QVNUaHByQ3I2Z1pIL2NpaTVzd0tIVGxlamoxQmpMVnNEV1o2eHpodjJ1a0FFZlFCd3NDZ1lFQTJiTWcKb0ZJS251c2xtNysyTm9JNW1OcUtKQVFDa040NjltRU1CQi82THZieksvUGZxVVNyc0xhQlVtL0xDNEZ4U2NlMApKbE9MOFNnNTRzS3F2SzZ0ZlA2SnQyWDM0cC9TZy9QVjRZT0lqNmpLTE5kWmdyVm41VGtDS1N2aVg4Rmp1YkFuCjFVS3pBRnNHYnEzQXdXbEw3TE9haC8yRVBtNUUzTm4vQVMwZEpPY0NnWUVBMFJvOE9VdmNhS3hjalRLZHNQL0kKc1RXZWZESVBkaEw1KzZ0cHBYTHFEelBzRHk4eTArU0tML2FNWmVnaEVuLzBmNlp3akhtN1lOTWJ3SmY2T1RSZwpBRCsxNkoxbmxHaWJHNW5pU3RnOTRiTUhSL1ZKTENwTlRoT3kxdUhSckhiNS9sWGUrWjg2M2NoOVRVOVNCck9ICmViR3dvelNwNkZ5YklrRncyZjlCUWJNQ2dZRUFwdzF2c2RhQzArUDVuZ1NFM0ZzZHU0K25oVytXVUhoWG9veGgKM2lCenFPcFRPNTBPT2lPNTVBYUlRaXdMRVM4cE1jYVBGUUh6VndEWk9vckszYkxrNmcrZ3VoMERGT0l6ZHBINwp3K3RkTlcvK2hGNVVENXNJdUxzQVQzdWZZSDlUK1QrVnNXNVhVYVNIMFJKLzRXcmRtaXRRSDU2SWhpZXpyQTJVClF1RE5obTBDZ1lCT3JtT3RYSFpPWGd5RzJGZ2E5UXIySnhnL3VaOEdaNFVnWHBFMkFmNy9KemQwSDUrY1F4cTMKTXBRVDRMa09EOXVMQkVRT3Y1dkxiMFVPV3JWNmVaSzRaS0lxZTlyTFBMQlU1K3N5V2NUZWxxUEZGRWJaNlZFcApjd0N3WVZqNW1QTm5wMkpaNUpSSG84NGZxVHg2MHFZYTJqSmFETFFNbmI4NEQxZFY1bGFoQ1E9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=" \
    SERVER_FACTS_BASE64="IyEvYmluL3NoCmVjaG8gImN1c3RvbWVyPWludGVybmFsIgplY2hvICJhcHA9aW5mcmFzdHJ1Y3R1cmUiCmVjaG8gInN0YWdlPWluZnJhc3RydWN0dXJlIgplY2hvICJoaWVyYV92ZXJzaW9uPSJgL3Vzci9iaW4vZW52IGhpZXJhIC1WIDI+JjEgfCBncmVwIC12IElnbm9yaW5nIHwgYXdrIC1GLiAne3ByaW50ICQxfSdgCg==" \
    UBUNTU_CODENAME=bionic \
    SERVER_FACTS_BASE64=factsbase64 \
    ENVIRONMENT=infrastructure

# NOTE: this is just documentation on defaults
RUN find / -path /sys -prune -o -path /proc -prune -o -uid `id -u puppet` -exec chown 3000:3000 {} \;
RUN find / -path /sys -prune -o -path /proc -prune -o -uid `id -g puppet` -exec chown 3000:3000 {} \;
RUN usermod -u 3000 puppet
RUN groupmod -g 3000 puppet

EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["start"]

# ADD https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb /

COPY scripts/test.sh /
COPY cmd.sh \
     docker-entrypoint.sh \
     healthcheck.sh \
     /
COPY docker-entrypoint.d/* /docker-entrypoint.d/
# k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=15s --retries=12 --start-period=3m CMD ["/healthcheck.sh"]

# no need to pin versions or clear apt cache as its still being used
# hadolint ignore=DL3008,DL3009
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh /docker-entrypoint.d/*.sh || true

COPY Dockerfile /
