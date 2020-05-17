
# Puppet In Kubernetes

This project is a fork of [Pupperware](https://github.com/puppetlabs/pupperware). It aims to combine the it with the best parts of [puppet-in-docker](https://github.com/vshn/puppet-in-docker).

Run a container-based deployment of Puppet Infrastructure.

To get started, you will need an installation of
[Docker Compose](https://docs.docker.com/compose/install/) on the host on
which you will run your Puppet Infrastructure.

# Vagrant
If you have Vagrant and VirtualBox installed and working on windows, you can just clone this repo and run vagrant up. It works best when you have the the same versions of
vagrant cli in wsl and vagrant in windows working together. To do this, read this [README-windows.md](./README-windows.md).

## Vagrant + Docker Compose
```
    git clone https://www.github.com/patchshorts/puppet-in-kubernetes
    cd puppet-in-kubernetes

    vagrant up dockercompose --provision
```
## Vagrant + Kubernetes
```
Stay tuned for these instructions.
```

Running Puppet Infrastructure in [Kubernetes](https://kubernetes.io/) is available as a helm chart from puppet labs. It doesn't have the eyaml and webhook features this module does. We may make our own chart soon.

To get started with that, you will need a running K8s cluster with [Helm](https://helm.sh/) deployed.

The Puppet Labs, Inc. Helm chart is [here](https://github.com/puppetlabs/puppetserver-helm-chart). It's hosted as a Helm chart [here](https://puppetlabs.github.io/puppetserver-helm-chart) and published in the fantastic [Helm Hub](https://hub.helm.sh/charts/puppet/puppetserver-helm-chart) and [Artifact Hub](https://artifacthub.io/package/chart/puppetserver/puppetserver-helm-chart). The latter will allow you to make use of it by just adding the repo in your configured Helm repos.

## Docker Compose

If you want to skip vagrant, just do this:
```
    git clone https://www.github.com/patchshorts/puppet-in-kubernetes
    cd puppet-in-kubernetes
    docker-compose up -d
    docker-compose logs -f
   
```

## Required versions

* Docker Compose - must support `version: '3'` of the compose file format, which requires Docker Engine `1.13.0+`. [Full compatibility matrix](https://docs.docker.com/compose/compose-file/compose-versioning/)
  * Linux is tested with docker-compose `1.22`
  * Windows is tested with `docker-compose version 1.26.0-rc3, build 46118bc5`
  * OSX is tested with `docker-compose version 1.23.2, build 1110ad01`
* Docker Engine support is only tested on versions newer than `17.09.0-ce`
  * Linux is tested with (client and server) `17.09.0-ce` using API version `1.32` (`Git commit:   afdb6d4`)
  * Windows is tested with Docker Desktop Edge 2.2.3.0 on Windows 10 2004 with WSL2 and Ubuntu 18.04
      - Client `19.03.8` using API version `1.40` (`Git commit:        afacb8b`)
      - Server `19.03.8` using API version `1.40 (minimum version 1.12)` (`Git commit:        afacb8b`) with `Experimental: true`
  * OSX is tested during development with `Docker Engine - Community` edition
      - Client `18.09.1` using API version `1.39` (`Git commit:        4c52b90`)
      - Server `18.09.1` using API version `1.39 (minimum version 1.12)` (`Git commit:       4c52b90`)

#Configuration

The provisioning command above will result in errors from the webhook container and so it is recommended at you put these values in your .env file before running docker-compose up:

| Name                                       | Usage / Default                                                                                                                                                                                            |
|--------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **EYAML_PRIVATE_BASE64**                   | The base64 encoded contents of your private pkcs7 pem                                                                                               |
| **EYAML_PUBLIC_BASE64**                    | The base64 encoded contents of your public pkcs7 pem |
| **HIERA_BASE64**                           | The base64 encoded contents of your hiera.yaml file |
| **R10K_CONTROL_REPO**                      | The ssh url to your git repo containing your Puppetfile branches |
| **R10K_HIERA_REPO**                        | The ssh url to your git repo containing your Hiera branches |
| **R10K_DEPLOY_KEY**                        | The base64 encoded contents of your ssh deploy key granted access to your r10k repos |
| **PUPPETSERVER_HOSTNAME**                  | The DNS name used on the masters SSL certificate - sets the `certname` and `server` in puppet.conf<br><br>Defaults to unset.                  |
| **DNS_ALT_NAMES**                          | Additional DNS names to add to the masters SSL certificate<br>**Note** only effective on initial run when certificates are generated                  |
| **PUPPET_MASTERPORT**                      | The port of the puppet master<br><br>`8140`                  |
| **AUTOSIGN**                               | Whether or not to enable autosigning on the puppetserver instance. Valid values match [true|false|/path/to/autosign.conf]. Defaults to 'true'.                  |
| **CA_ENABLED**                             | Whether or not this puppetserver instance has a running CA (Certificate Authority)<br><br>`true`                  |
| **CA_HOSTNAME**                            | The DNS hostname for the puppetserver running the CA. Does nothing unless `CA_ENABLED=false`<br><br>`puppet`                  |
| **CA_MASTERPORT**                          | The listening port of the CA. Does nothing unless `CA_ENABLED=false`<br><br>`8140`                  |
| **CA_ALLOW_SUBJECT_ALT_NAMES**             | Whether or not SSL certificates containing Subject Alternative Names should be signed by the CA. Does nothing unless `CA_ENABLED=true`.<br><br>`false`                  |
| **PUPPET_REPORTS**                         | Sets `reports` in puppet.conf<br><br>`puppetdb`                  |
| **PUPPET_STORECONFIGS**                    | Sets `storeconfigs` in puppet.conf<br><br>`true`                  |
| **PUPPET_STORECONFIGS_BACKEND**            | Sets `storeconfigs_backend` in puppet.conf<br><br>`puppetdb`                  |
| **PUPPETDB_SERVER_URLS**                   | The `server_urls` to set in `/etc/puppetlabs/puppet/puppetdb.conf`<br><br>`https://puppetdb:8081`                  |
| **USE_PUPPETDB**                           | Whether to connect to puppetdb<br>Sets `PUPPET_REPORTS` to `log` and `PUPPET_STORECONFIGS` to `false` if those unset<br><br>`true`                  |
| **PUPPETSERVER_MAX_ACTIVE_INSTANCES**      | The maximum number of JRuby instances allowed<br><br>`1`                  |
| **PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE** | The maximum HTTP requests a JRuby instance will handle in its lifetime (disable instance flushing)<br><br>`0`                  |
| **PUPPETSERVER_JAVA_ARGS**                 | Arguments passed directly to the JVM when starting the service<br><br>`-Xms512m -Xmx512m`                  |
| **ANALYTICS_ENABLED**                      | Set to `true` to enable Google Analytics<br><br>`false`       |


An example .env file looks like this.

```
# Required

R10K_CONTROL_REPO=ssh://github.com/path/to/repo/with/Puppetfile # use ssh
R10K_DEPLOY_KEY_BASE64=fullyunquotedbase64id_rsafilecontents # This is your deploy key

# Optional
R10K_HIERA_REPO=ssh://github.com/path/to/repo/with/yaml #use ssh
HIERA_BASE64=fullyunquotedbase64string
EYAML_PRIVATE_BASE64=fullyunquotedbase64string
EYAML_PUBLIC_BASE64=fullyunquotedbase64string
POSTGRES_PASSWORD=puppetdb
PUPPETDB_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_USER=puppetdb
PUPPETDB_USER=${POSTGRES_USER}

ANALYTICS_ENABLED=false
PUPPETDB_POSTGRES_HOSTNAME=postgres
PUPPETDB_SERVER_URLS=https://puppetdb:8081
PUPPETSERVER_HOSTNAME=puppet

```

The value of `DNS_ALT_NAMES` must list all the names, as a comma-separated
list, under which the Puppet server in the stack can be reached from
agents. It will have `puppet` prepended to it as that
name is used by PuppetDB to communicate with the Puppet server. The value of
`DNS_ALT_NAMES` only has an effect the first time you start the stack, as it
is placed into the server's SSL certificate. If you need to change it after
that, you will need to properly revoke the server's certificate and restart
the stack with the changed `DNS_ALT_NAMES` value.

When you first start the Puppet Infrastructure, the stack will create a number of Docker volumes to store the persistent data that should survive the restart of your infrastructure. The actual location on disk of these volumes may be examined with the `docker inspect` command. The following volumes include:

* `puppetserver-code`: the Puppet code directory.
* `puppetserver-config`: Puppet configuration files, including `puppet/ssl/` containing certificates for your infrastructure. This volume is populated with default configuration files if they are not present when the stack starts
up.
* `puppetdb-ssl`: certificates in use by the PuppetDB instance in the
  stack.
* `puppetdb-postgres`: the data files for the PostgreSQL instance used by
PuppetDB
* `puppetserver-data`: persistent data for Puppet Server

## Container Versions

By default, the puppetserver and puppetdb containers will use the `latest` tag.
`PUPPETSERVER_VERSION` and `PUPPETDB_VERSION` environment variables have been
added to the compose file so you can pin versions if you need to by setting those
on the command line, or in a `.env` file.

## PuppetInKubernetes on Windows (using WSL2)

Complete instructions for provisiong a server with WSL2 support are in [README-windows.md](./README-windows.md)

Creating the stack from PowerShell is nearly identical to other platforms, aside from how environment variables are declared:

``` powershell
PS> $ENV:DNS_ALT_NAMES = 'host.example.com'

PS> docker-compose up
Creating network "puppetinkubernetes_default" with the default driver
Creating volume "puppetinkubernetes_puppetserver-code" with default driver
Creating volume "puppetinkubernetes_puppetserver-config" with default driver
Creating volume "puppetinkubernetes_puppetserver-data" with default driver
Creating volume "puppetinkubernetes_puppetdb-ssl" with default driver
Creating volume "puppetinkubernetes_puppetdb-postgres" with default driver
Creating puppetinkubernetes_postgres_1 ...

Creating puppetinkubernetes_puppet_1   ...

Creating puppetinkubernetes_puppet_1   ... done

Creating puppetinkubernetes_postgres_1 ... done

Creating puppetinkubernetes_puppetdb_1 ...

Creating puppetinkubernetes_puppetdb_1 ... done

...
```

To delete the stack:

``` powershell
PS> docker-compose down
Removing network puppetinkubernetes_default
...
```

## Managing the stack

The script `bin/puppet` (or `bin\puppet.ps1` on Windows) makes it easy to run `puppet` commands on the
puppet master. For example, `./bin/puppet config print autosign --section
master` prints the current setting for autosigning, which is `true` by
default. In a similar manner, any other task that you would perform on a
puppet master by running `puppet x y z ...` can be achieved against the
stack by running `./bin/puppet x y z ...`.

There is also a similar script providing easy access to `puppetserver` commands. This is particularly
useful for CA and cert management via the `ca` subcommand.

### Changing postgresql password

The postgresql instance uses password authentication for communication with the
puppetdb instance. If you need to change the postgresql password, you'll need to
do the following:
* update the password in postgresql: `docker-compose exec postgres /bin/bash -c "psql -U \$POSTGRES_USER -c \"ALTER USER \$POSTGRES_USER PASSWORD '$dbpassword'\";"`
* update values for `PUPPETDB_PASSWORD` and `POSTGRES_PASSWORD` in docker-compose.yml
* rebuild and restart containers affected by these changes: `docker-compose up --detach --build`

## Running tests

### Running tests locally
This repo contains some simple tests that can be run with [RSpec](http://rspec.info).
To run these tests you need to have Ruby, Docker, and Docker Compose installed on the
machine where you're running the tests. The tests depend on the 'rspec' and 'json'
rubygems. The tests are known to run on at least ruby 1.9.3-p551 and as new as
ruby 2.4.3p205.

**NOTE** These tests will start and stop the cluster
running from the current checkout, so be careful where you run them
from.

To run the tests:
1. `bundle install --with test`
2. `bundle exec rspec spec`

## Containers

The containers used in are generated based on dockerfiles in the
repos for [puppetserver](https://github.com/puppetlabs/puppetserver/tree/master/docker)
and [puppetdb](https://github.com/puppetlabs/puppetdb/tree/master/docker).
Published containers can be found on [dockerhub](https://hub.docker.com/u/puppet).

## Analytics Data Collection

The Puppet owned containers run in the stack collect usage data. You can opt out of providing this data.

### What data is collected?
* Version of the puppetserver container.
* Version of the puppetdb container.
* Anonymized IP address is used by Google Analytics for Geolocation data, but the IP address is not collected.

### Why do we collect data?

We collect data to help us understand how the containers are used and make decisions about upcoming changes.

### How can I opt out of container data collection?

Create a `.env` file in this directory with the contents:

```
ANALYTICS_ENABLED=false
```

This file is in the `.gitignore` file and will not be managed or changed. It is used only when you're running tests with docker-compose.

When running in kubernetes, you may have to copy the contents of this file into your kustomize.yaml appropriatly. Samples are in the kubernetes folder.

## License

See [LICENSE](LICENSE) file.

## Issue Tracking

Please report any issues as GitHub issues in this repo.

## Contact us!

If you have questions or comments about this project, feel free to send a message
to patchshorts hat gmail got com. You could probably get help with this on from people who use pupperware as this project is a fork of that project.
So you may find help by reaching out in the #puppet channel in the [puppet community slack](https://slack.puppet.com/).
