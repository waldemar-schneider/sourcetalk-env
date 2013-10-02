#!/bin/bash
wget -q -O h2.zip http://www.h2database.com/h2-2013-07-28.zip
unzip h2.zip
sh /vagrant/start-h2.sh
