# -*- mode: ruby -*-
# vi: set ft=ruby :

$script_ci = <<SCRIPT
echo Provisioning VM...
echo Installing dependencies...
apt-get -qy install git openjdk-7-jdk unzip

#echo Installing webapps...
#chmod 777 /usr/share/tomcat7
#wget -q -O /var/lib/tomcat7/webapps/jenkins.war http://mirrors.jenkins-ci.org/war/latest/jenkins.war
#wget -q -O /var/lib/tomcat7/webapps/nexus.war http://www.sonatype.org/downloads/nexus-latest.war
#service tomcat7 restart

echo Done.
SCRIPT

$script_lb = <<SCRIPT
echo Provisioning VM...
echo Installing dependencies...
apt-get -qy install nginx
echo "upstream myCloud {             " >  /etc/nginx/sites-available/default
echo "  server 10.0.2.2:38080;       " >> /etc/nginx/sites-available/default
echo "  server 10.0.2.2:48080;       " >> /etc/nginx/sites-available/default
echo "}                              " >> /etc/nginx/sites-available/default
echo "                               " >> /etc/nginx/sites-available/default
echo "server {                       " >> /etc/nginx/sites-available/default
echo "  listen 80;                   " >> /etc/nginx/sites-available/default
echo "                               " >> /etc/nginx/sites-available/default
echo "  location / {                 " >> /etc/nginx/sites-available/default
echo "    proxy_pass http://myCloud; " >> /etc/nginx/sites-available/default
echo "  }                            " >> /etc/nginx/sites-available/default
echo "}                              " >> /etc/nginx/sites-available/default
service nginx restart
echo Done.
SCRIPT

$script_app = <<SCRIPT
echo Provisioning VM...
echo Installing dependencies...
apt-get -qy install openjdk-7-jre-headless
echo Done.
SCRIPT

$script_db = <<SCRIPT
echo Provisioning VM...
echo Installing dependencies...
apt-get -qy install openjdk-7-jre-headless
echo Done.
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "raring-server-cloudimg-amd64-vagrant"
  config.vm.box_url = "http://cloud-images.ubuntu.com/raring/current/raring-server-cloudimg-vagrant-amd64-disk1.box"

  config.vm.define "ci" do |ci|
    ci.vm.hostname = "ci"
    ci.vm.provision :shell, :inline => $script_ci
    ci.vm.network "forwarded_port", guest: 8001, host: 18001
    ci.vm.network "forwarded_port", guest: 8081, host: 18081
    ci.vm.provider "virtualbox" do |vm|
      vm.customize [
                     'modifyvm', :id,
                     '--memory', '2048',
                     '--cpus', '2',
                 ]
    end
  end

  config.vm.define "lb" do |lb|
    lb.vm.hostname = "lb"
    lb.vm.provision :shell, :inline => $script_lb
    lb.vm.network "forwarded_port", guest: 80, host: 20080
    lb.vm.provider "virtualbox" do |vm|
      vm.customize [
                     'modifyvm', :id,
                     '--memory', '512'
                 ]
    end
  end

  config.vm.define "app1" do |app1|
    app1.vm.hostname = "app1"
    app1.vm.provision :shell, :inline => $script_app
    app1.vm.network "forwarded_port", guest: 22,   host: 30022
    app1.vm.network "forwarded_port", guest: 8080, host: 38080
    app1.vm.provider "virtualbox" do |vm|
      vm.customize [
                     'modifyvm', :id,
                     '--memory', '512'
                 ]
    end
  end

  config.vm.define "app2" do |app2|
    app2.vm.hostname = "app2"
    app2.vm.provision :shell, :inline => $script_app
    app2.vm.network "forwarded_port", guest: 22,   host: 40022
    app2.vm.network "forwarded_port", guest: 8080, host: 48080
    app2.vm.provider "virtualbox" do |vm|
      vm.customize [
                     'modifyvm', :id,
                     '--memory', '512'
                 ]
    end
  end

  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.provision :shell, :inline => $script_db
    db.vm.network "forwarded_port", guest: 9092, host: 59092
    db.vm.provider "virtualbox" do |vm|
      vm.customize [
                     'modifyvm', :id,
                     '--memory', '512'
                 ]
    end
  end
end