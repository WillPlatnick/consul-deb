#!/bin/sh

TIMESTAMP=`date +%s`
TYPES="rpm deb"

# Download sources
if [ ! -f rootfs/usr/bin/consul ]
then
  mkdir -p rootfs/usr/bin
  echo "Downloading sources (1/2)..."
  URL=https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip
  wget -qO tmp.zip $URL && unzip tmp.zip -d rootfs/usr/bin && rm tmp.zip
  chmod 0755 rootfs/usr/bin/consul
fi
if [ ! -d rootfs/usr/share/consul-ui ]
then
  mkdir -p rootfs/usr/share
  echo "Downloading sources (2/2)..."
  URL=https://dl.bintray.com/mitchellh/consul/0.5.0_web_ui.zip
  wget -qO tmp.zip $URL && unzip tmp.zip -d rootfs/usr/share && rm tmp.zip
  mv rootfs/usr/share/dist rootfs/usr/share/consul-ui
  rm rootfs/usr/share/consul-ui/.gitkeep
fi

# Delete existing packages
for TYPE in $TYPES
do
  rm *."$TYPE" -f
done

# Create package
for TYPE in $TYPES
do
  echo "Creating $TYPE package..."
  fpm -s dir -t $TYPE -C rootfs -n consul -v 0.5.0 \
  --iteration $TIMESTAMP --epoch $TIMESTAMP \
  --after-install meta/after-install.sh \
  --before-remove meta/before-remove.sh \
  --after-remove meta/after-remove.sh
done
