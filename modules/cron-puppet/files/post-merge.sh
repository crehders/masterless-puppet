#!/bin/bash

/usr/bin/logger -i "git pull successfull, doing puppet apply now" -t "puppet-run"

## Run Puppet locally using puppet apply
/usr/bin/puppet apply /etc/puppet/manifests/site.pp

## Log status of the Puppet run
if [ $? -eq 0 ]
then
    /usr/bin/logger -i "Puppet has run successfully" -t "puppet-run"
    exit 0
else
    /usr/bin/logger -i "Puppet has ran into an error, please run Puppet manually" -t "puppet-run"
    exit 1
fi