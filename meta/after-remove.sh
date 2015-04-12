#!/bin/sh

USER=consul

# Delete user
if id -u $USER > /dev/null 2>&1
then
  userdel $USER
  rm -f /var/spool/mail/$USER
fi
