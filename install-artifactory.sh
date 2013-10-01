#!/bin/bash
wget -q -O artifactory.zip http://dl.bintray.com/content/jfrog/artifactory/artifactory-3.0.3.zip?direct
unzip artifactory.zip
sh /vagrant/start-artifactory.sh
