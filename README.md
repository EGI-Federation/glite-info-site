# Site component for the glite-info-static framework

This repository contains the site component for the
 [glite-info-static](https://github.com/EGI-Federation/glite-info-static) framework.
BDII documentation is available at
[gridinfo documentation site](https://gridinfo-documentation.readthedocs.io/).

## Installing from source

```shell
$ make install
```

- Build dependencies: None
- Runtime dependencies: None

## Installing from packages

### On RHEL-based systems

On RHEL-based systems, it's possible to install packages from
[EGI UMD packages](https://go.egi.eu/umd). The packages are build from this repository,
and tested to work with other components part of the Unified Middleware Distribution.

## Building packages

Individual Makefiles allowing to build source tarball and packages are provided.

### Building a RPM

The required build dependencies are:

- rpm-build
- make
- rsync

```shell
# Checkout tag to be packaged
$ git clone https://github.com/EGI-Foundation/glite-info-site.git
$ git checkout X.X.X
# Building in a container
$ docker run --rm -v $(pwd):/source -it quay.io/centos/centos:7
[root@8a9d60c61f42 /]# yum install -y rpm-build yum-utils
[root@8a9d60c61f42 /]# cd /source
[root@8a9d60c61f42 source]# yum-builddep -y glite-info-site.spec
[root@8a9d60c61f42 source]# make rpm
```

The RPM will be available into the `build/RPMS` directory.

## Preparing a release

- Prepare a changelog from the last version, including contributors' names
- Prepare a PR with
  - Updating version and changelog in
    - [CHANGELOG](CHANGELOG)
    - [glite-info-site.spec](glite-info-site.spec)
- Once the PR has been merged tag and release a new version in GitHub
  - Packages will be built using GitHub Actions and attached to the release page

## History

This work started under the EGEE project, and was hosted and maintained for a
long time by CERN. This is now hosted here on GitHub, maintained by the BDII
community with support of members of the EGI Federation.
