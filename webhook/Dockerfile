FROM ubuntu:18.04

ARG PUPPET_AGENT_VERSION="5.4.0"
ENV R10K_VERSION="2.6.2" \
    DUMB_INIT_VERSION="1.2.2" \
    UBUNTU_CODENAME="bionic" \
    SINATRA_VERSION="2.0.8.1" \
    PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH \
    R10K_CONTROL_REPO="ssh://git@gitlab.com/puppet-control/sample-control.git" \
    R10K_HIERA_REPO="" \
    R10K_DEPLOY_KEY_BASE64="LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBNmw3Vi9GS05mU0pUUHNWY3RpRXJ1RmFvTnNqN1ZNS1hxTmlreDhPaVRIZ1ErVmlBCkhSdVlJUGZnNHE1SHIvNVRrYjZmYW54Y2p0RFVjWGdWT0Q0WE83NE9ZWWhBYlVIWXU5N1hqdkJkcEJXS2R4cmoKcWJDdUlpbzhFN3N0aFgyWno1ZXFybDZoV0tOcjNqQVVTRlFKdlF6amcxR3JEWENHenVucjFWYjhqbUg0RkZYTgo2UURUQXBOdWNSclhUaEw1YWlSQVRMQ295My9ES3k5OUllVE9vdk9JL0ltY29GK0ZacjNqa2VFR3ZzN3gvNTFiCmJuaXl3WTltUnpLNHoveTlaanRnWEpZOFNKZzJsN3lHa0l6eGYxeG1pc21LN2dId2NyL2lMTDZjMFJNczNhS0YKMERuQ1prUXpmVFdwdytzUHVOZ1R2bldLQnFlak5FRzN0emJNWFFJREFRQUJBb0lCQUErYVRxNmtwRXkvVzBGagpqRCtIeDh4VzRJMzlKVlpJT2lhQWZiL2EwMVE1N2c5YmgvUG9JV0dZZnYwNFV3ZHhiQWpZNHU0STUzU09qSVlkClUzUlNGZVBoVEQzTC8xWUd1eklPck5VVVJYZW1BM2pZYm0yZW1Ja252S1lub09reEttczZrcDlYSjNDcU9JVXIKT0Q1MGNjMkhMU0pSN294UGdIb0g4cTVhUXlnTFZ3VWUwTVZoQUlCckFJN2xkMWx2WW4wWkFHQStOdG80NmFEcQpmQlllOWZQUDBTaEhkdE1nMEtZN2gxeTQ0UGpwRzNxUk5FYkFmd2ZBV2RzRE5LOUJFQm9uY2ZFLzhJY2Ivd3ZkClkyZU9PU3lUOGI1UVAvMVcrTmR2ZjNyQmc4ZFd4Q01HNW5ZMWJMbGU0UGtyK3B4Ulg4YjNHSVhlRmlkQXB5SVUKRXFhN1lhRUNnWUVBK1ZWUDNPWTRuM0NTcUhnL0tVb2x1bjBSS0w0RkNWbFhleHBjd2dqckdjSzdZbVBTcEthTQptUmhnUEx5SFJJTGQrNmlXMUlsNHdCSlBrcVc2OVlNOHFjd1BCeGlwbm1qOGhiaSsvRGxnaVRyb0VlMVVCM0xrCnVvaGI2aFVGZUZJK0U5b1plZlJjQVZIb3dUVm9JZnRhaEo2TGloZ2R2aEI5S3A4WjRHRWtTYmtDZ1lFQThLTWEKZS9GQVlCU0duT2ZJUG11OUl2Zm1scUlzcytYZzhQRnMzdHFaMDdHV0NHNk1xR0NrNEVaZ0k4d0IwbzduUWd6Ugo1NGtDcU9wUUdsQWo3d3Rtb25hemg5OFJpVldTdzF5bHNCSnRqWHFwMHM5ellpMXVLL20rVlgwZFJSR2JHVUs1CjgrbTRZYzJQUElmd0MxRGVPVW9nY2FkZEJJRXR5dnA1eElOUEdjVUNnWUVBdUdNZzVvblRBZ1lzVHk1dDkwa0EKVWNPLzl0TmZ3aVF5RDdYVk55R0ZTODI0NmZCTWpMc21hdW1kOGd5eU5EWmJsNHA3MEwzQmNMbVo0eWR3OWJPUwpIemZyUFNJOS9ncENCVm8wMHk1VGQrajZTcGVxZHIrKzZ6dUFUY0l5QTJNK3lVdVhYNXNZbDFsTnVlU1hGOXBjCmZJc0xRcHJIRkJINW5wVitlM01iZFBFQ2dZRUF0UzRaQXJqaWYzVDA1YTZlVm1GSVJzdmdFZ3FKSGVvM016S1QKaGplUkdwTGJJLzRZYWE1YWRZS0hZR3g1OHM4bHo5VlhOYjB6QTN0b1ZHZUNwcmt1emFRU0NIc3IrUHMxUldLOApYWldDWnNPMG1jVVlXeE5ab0VLcHpEUW5sWmxyN2RrUHFWYVFQUk5JaFlyVWNiQ3hvUER1L0tQR3BWMmQzUFk2Ck9IdWxVd0VDZ1lFQTFDOTQzZDh2d0MwTytzWEsyMVVQeTZuWXNXdVNuYlNyKzNQSE84WkVRVjh2QnRleFplMDYKS3dxZFg3WWt4RlJFVlVmUURiTlczRWJ0UGlNRVRzMWw4djBUTkFxbm9McmQ1aUJpRk1CQkNNWDZYT0x0aXZNawpRbmV2Z29ER0FoYjVwNFczRWR6ckkwcVRwaGx0YlNWK0tVYjhpM0NXUldmNG8yRitUV1pXSkJRPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo="

LABEL org.label-schema.maintainer="Chris Godwin <patchshorts@gmail.com>" \
      org.label-schema.vendor="Puppet In Kubernetes" \
      org.label-schema.url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/patchshorts/puppet-in-kubernetes" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="Puppet r10k and Webhook" \
      com.puppet.dockerfile="/Dockerfile"

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["/usr/local/bin/webhook"]

COPY Dockerfile /

# TODO checksum check
RUN apt-get update && \
    apt-get install -y wget git netcat && \
    wget https://apt.puppetlabs.com/puppet6-release-"${UBUNTU_CODENAME}".deb && \
    wget https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    dpkg -i puppet6-release-"${UBUNTU_CODENAME}".deb && \
    dpkg -i dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    rm puppet6-release-"${UBUNTU_CODENAME}".deb dumb-init_"${DUMB_INIT_VERSION}"_amd64.deb && \
    apt-get update && \
    apt-get install --no-install-recommends -y r10k puppet-agent && \
    gem install sinatra && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure .ssh directory
RUN mkdir /root/.ssh \
  && chmod 0600 /root/.ssh \
  && echo StrictHostKeyChecking no > /root/.ssh/config

# Add configuration file into the image
COPY scripts/test.sh /
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
COPY webhook /usr/local/bin/
COPY webhook.yaml /etc/webhook.yaml
RUN chmod a+x /usr/local/bin/webhook
RUN mkdir -p /var/run/webhook /var/log/webhook
RUN find / -uid `id -u puppet` -exec chown 3000:3000 {} \;
RUN find / -gid `id -g puppet` -exec chown 3000:3000 {} \;
RUN usermod -u 3000 puppet
RUN groupmod -g 3000 puppet
# Copy entrypoint into container
COPY docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
