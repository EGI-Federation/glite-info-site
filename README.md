# glite-info-site

Documentation: http://gridinfo-documentation.readthedocs.io

## Installing from source

```sh
make install
```

* Build dependencies: None
* Runtime dependencies: openldap

## Building packages

* It is possible to easily build pacakges CentOS using the provided
  `Makefile-build-docker` makefile leveraging the use of docker
  containers.

```sh
# Building a CentOS 7 RPM
make -f Makefile-build-docker rpm
```

