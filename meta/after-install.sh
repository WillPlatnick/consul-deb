#!/bin/sh

USER=consul

# Add user
if ! id -u $USER > /dev/null 2>&1
then
  useradd -M $USER
fi

mkdir -p /var/consul
chown $USER:$USER /var/consul
