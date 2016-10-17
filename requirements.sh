#!/usr/bin/env bash

mkdir -p ./files

[[ ! -e ./files/puppet-student.ova ]] && wget -O ./files/puppet-student.ova http://downloads.puppet.com/training/puppet-student.ova
[[ -e ./files/puppet-student.ova ]] && echo "PuppetConf 2016 Student OVA file was downloaded"

VBoxManage list vms | grep -q student || VBoxManage import files/puppet-student.ova 2>&1 >/dev/null
VBoxManage list vms | grep -q student && echo "PuppetConf 2016 Student VM was imported into VirtualBox"

VBoxManage list runningvms | grep -q student || VBoxManage startvm student
VBoxManage list runningvms | grep -q student && echo "PuppetConf 2016 Student VM is running" && \
echo -e "Use SSH to log in: \n  ssh root@10.0.2.15\nView the VM in VirtualBox to know the randomly generated password"
