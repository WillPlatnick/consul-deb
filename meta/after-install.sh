#!/bin/sh

USER=consul

# Add user
if ! id -u $USER > /dev/null 2>&1
then
  useradd -M $USER
fi

mkdir -p /opt/consul
chown -R $USER:$USER /opt/consul
