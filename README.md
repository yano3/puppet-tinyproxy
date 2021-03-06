# tinyproxy [![Build Status](https://travis-ci.org/hfm/puppet-tinyproxy.svg?branch=master)](https://travis-ci.org/hfm/puppet-tinyproxy) [![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/tinyproxy.svg?style=flat-square)](https://forge.puppet.com/hfm/tinyproxy)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with tinyproxy](#setup)
  - [Setup requirements](#setup-requirements)
  - [Beginning with tinyproxy](#beginning-with-tinyproxy)
1. [Usage - Configuration options and additional functionality](#usage)
  - [Configuring tinyproxy](#configuring-tinyproxy)
  - [Configuring modules from Hiera](#configuring-modules-from-hiera)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  - [Public Classes](#public-classes)
  - [Private Classes](#private-classes)
  - [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
  - [Running tests](#running-tests)
  - [Testing quickstart](#testing-quickstart)

## Description

The tinyproxy module handles installing, configuring, and running [tinyproxy](http://tinyproxy.github.io).

## Setup

### Setup Requirements

The tinyproxy module requires the following puppet modules:

- [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib) (>= 4.0.0 < 5.0.0)
- [puppetlabs-apt](https://forge.puppet.com/puppetlabs/apt) (>= 2.0.0 < 3.0.0) (only Debian-based distributions)
- [stahnma-epel](https://forge.puppet.com/stahnma/epel) (>= 1.0.0 < 2.0.0) (only RedHat-based distributions)

### Beginning with tinyproxy

To install the tinyproxy with default parameters, declare the `tinyproxy` class.

```puppet
include ::tinyproxy
```

## Usage

### Configuring tinyproxy

```puppet
class { '::tinyproxy':
  use_epel       => true,
  package_ensure => 'installed',
  config_ensure  => 'file',
  service_ensure => 'running',
  service_enable => true,
}
```

### Configuring modules from Hiera

```yaml
---
tinyproxy::use_epel: true
tinyproxy::package_ensure: installed
tinyproxy::config_ensure: file
tinyproxy::service_ensure: running
tinyproxy::service_enable: true
```
## Reference

### Public Classes

- [`tinyproxy`](#tinyproxy): Installs, configures, and runs tinyproxy.

### Private Classes

- `tinyproxy::install`: Installs the tinyproxy package.
- `tinyproxy::config`: Configures tinyproxy.conf.
- `tinyproxy::service`: Manages service.

### Parameters

#### Class: `tinyproxy`

- `use_epel`: Whether epel repository should be installed. Type is Boolean. Default: true.
- `package_ensure`: What state the tinyproxy package should be in. Type is String. Default: 'installed'.
- `config_ensure`: Whether the tinyproxy.conf should exist. Type is Enum['file', 'absent']. Default: 'file'.
- `service_ensure`: Whether a service should be running. Type is Enum['running', 'stopped']. Default: 'running'.
- `service_enable`: Whether a service should be enabled to start at boot. Type is Boolean. Default: true.

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 7
- CentOS 7
- Scientific Linux 7
- Debian 8
- Ubuntu 16.04

## Development

### Running tests

The tinyproxy module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake test
```

- Acceptance tests using docker:

```console
# List available beaker nodesets
$ bundle exec rake beaker_nodes
centos7
jessie
xenial

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```
