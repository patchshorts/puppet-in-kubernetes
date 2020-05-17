# [puppetlabs/r10k](https://github.com/puppetlabs/r10k)

r10k and sinatra webhook on a Docker image. Based on ubuntu 18.04.

## Configuration

The following environment variables are supported:

- `ANALYTICS_ENABLED`

  Set to 'true' to enable Google Analytics metrics. Defaults to 'false'.

## Analytics Data Collection

The r10k container collects usage data. This is disabled by default. You can enable it by passing `--env ANALYTICS_ENABLED=true`
to your `docker run` command.

### What data is collected?
* Version of the r10k container.
* Anonymized IP address is used by Google Analytics for Geolocation data, but the IP address is not collected.

### Why does the r10k container collect data?

We collect data to help us understand how the containers are used and make decisions about upcoming changes.

### How can I opt out of r10k container data collection?

This is disabled by default.
# r10k including Webhook

[Docker Hub: `patchshorts/webhook`](https://hub.docker.com/r/patchshorts/webhook/)

## Introduction

r10k is used for Puppet code deployment. r10k runs can be triggered from remote webhook listening on port 8088.

## Usage

### Environment variables

| Name                          | Description                                                           | Default value        |
| ----                          | -----------                                                           | -------------        |
| PUPPETDB                      | Hostname of PuppetDB                                                  | puppetdb.local       |
| PUPPETSERVER                  | Hostname of Puppetserver                                              | puppetserver.local   |
| R10K_ADDITIONAL_CONFIG_BASE64 | Base64 encoded string to append to r10k.yaml configuration file       | -                    |
| R10K_DEPLOY_KEY               | SSH key for accessing private git repositories (use only one of these)| -                    |
| R10K_DEPLOY_KEY_BASE64        | SSH key for accessing private git repositories (Base64 encoded)       | -                    |
| R10K_CONTROL_REPO             | r10k control repository containing Puppetfile (required)              | -                    |
| R10K_HIERA_REPO               | r10k hiera repository (optional)                                      | -                    |

### r10k configuration

r10k is configured using a configuration file saved inside the image. This repository
contains a simpile configuration file which is not useable for production. Setting the
environment variables `R10K_CONTROL_REPO` is therefore mandatory and `R10K_HIERA_REPO` is optional.

Regarding the above, some use cases require having application level puppet module conflicts resolved through branch/environment separation,
while hiera might need to conform to a sensible multi-tenancy structure. So one may have stage_drupal7, stage_drupal8 as control environents,
but hiera needs to be stored as %{customer}/%{drupal_version}/%{devel} and %{customer}/%{drupal_version}/%{stage}.

The reason to maintain this separation is puppet environments are stages of puppet code while hiera stages are stages of configuration release
relating to application code. Your application codebase and your puppet code base are separate.

To further customize the r10k configuration, you should base64 encode the R10K_ADDITIONAL_CONFIG_BASE64 env variable.
You can also create your own image by editing our Dockerfile, or making your own containing the text below.
Example:

```
FROM patchshorts/webhook:5.2
COPY r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
```

The cache directory specified in the r10k.yaml configuration file should be defined
as Docker volume. In the default configuration this is `/opt/puppetlabs/r10k/cache`.

For checking out code from a private git repository a SSH deploy key is most likely
needed. It can be configured with the environment variable `R10K_DEPLOY_KEY` or
mounted to `/root/.ssh/id_rsa`.

### Code sharing with Puppetserver

The code checked out by r10k is saved under `/etc/puppetlabs/code/environments` and if you specify the env variable R10K_HIERA_REPO then `/etc/puppetlabs/code/hieradata` as well. Both of these
directories should be defined as volume and shared with the Puppet container.

Example with Docker Compose:

```
  puppet:
    volumes:
      - puppet_code:/etc/puppetlabs/code/
  webhook:
    volumes:
      - puppet_code:/etc/puppetlabs/code/
```

### Login

To use login to the webhook container to debug r10k, run the following command:
```
docker-compose exec webhook bash
```

## Details

* Ports exposed: - 8088
* Volumes: - puppet_code
* Based on: `ubuntu:18.04`

### Entrypoint scripts

| Name              | Description                                                  |
| ----              | -----------                                                  |
| 10-analytics.sh   | Request a url which allows us to count the usage of this code|
| 20-r10k-config.sh | Configures contro repo, deploy key and mco policy            |
