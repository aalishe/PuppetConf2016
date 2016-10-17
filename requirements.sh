#!/usr/bin/env bash

mkdir -p ./files

[[ ! -e ./files/puppet-student.ova ]] && wget -O ./files/puppet-student.ova http://downloads.puppet.com/training/puppet-student.ova
[[ -e ./files/puppet-student.ova ]] && echo -e "\x1B[92;1mPuppetConf 2016 Student OVA file was downloaded\x1B[0m"

VBoxManage list vms | grep -q student || VBoxManage import files/puppet-student.ova 2>&1 >/dev/null
VBoxManage list vms | grep -q student && echo -e "\x1B[92;1mPuppetConf 2016 Student VM was imported into VirtualBox\x1B[0m"

VBoxManage list runningvms | grep -q student || VBoxManage startvm student 2>&1 >/dev/null
VBoxManage list runningvms | grep -q student && echo -e "\x1B[92;1mPuppetConf 2016 Student VM is running\x1B[0m" && \
echo -e "Use SSH to log in: \n  \x1B[92;1mssh root@10.0.2.15\x1B[0m\nView the VM in VirtualBox to know the randomly generated password"
