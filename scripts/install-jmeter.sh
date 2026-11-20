#!/usr/bin/env bash
# Installe Apache JMeter 5.6.3 dans le dossier personnel
set -e
VERSION=5.6.3
cd "$HOME"
if [ -x "$HOME/apache-jmeter-$VERSION/bin/jmeter" ]; then
    echo "JMeter $VERSION est déjà installé dans $HOME/apache-jmeter-$VERSION"
    exit 0
fi
wget "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$VERSION.tgz"
tar -xzf "apache-jmeter-$VERSION.tgz"
rm "apache-jmeter-$VERSION.tgz"
echo "JMeter installé : $HOME/apache-jmeter-$VERSION/bin/jmeter"
