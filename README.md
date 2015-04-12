Scope
=====

This is a FPM-based package builder for Consul.

Usage
=====

Install the required dependencies (CentOS 6.6).

    sudo yum install ruby-devel rubygems gcc rpm-build
    sudo gem install fpm

Build the supported packages.

    ./build.sh
