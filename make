#!/usr/bin/env bash

help() {
  cat <<'EOH'
Script to make all the required actions during the PuppetConf 2016 training.

Use:
    ./make <command> <parameters>

Available commands are:
  help:         Print this help
  init:         Initialize the environment for the PuppetConf. Download and run the student VM
  set-password: Set the randomly generated password in the student VM
  ssh:          SSH to the student VM
EOH
}

init() {
  mkdir -p ./files

  [[ ! -e ./files/puppet-student.ova ]] && wget -O ./files/puppet-student.ova http://downloads.puppet.com/training/puppet-student.ova
  [[ -e ./files/puppet-student.ova ]] && echo -e "\x1B[92;1mPuppetConf 2016 Student OVA file was downloaded\x1B[0m"

  VBoxManage list vms | grep -q student || VBoxManage import files/puppet-student.ova 2>&1 >/dev/null
  VBoxManage list vms | grep -q student && echo -e "\x1B[92;1mPuppetConf 2016 Student VM was imported into VirtualBox\x1B[0m"

  VBoxManage list runningvms | grep -q student || VBoxManage startvm student 2>&1 >/dev/null
  VBoxManage list runningvms | grep -q student && echo -e "\x1B[92;1mPuppetConf 2016 Student VM is running\x1B[0m" && \
  echo -e "View the VM in VirtualBox to know the randomly generated password and set it with command set-password:\n  \x1B[92;1m$0 set-password <password>\x1B[0m\n" && \
  echo -e "Use SSH command to log in: \n  \x1B[92;1m$0 ssh\x1B[0m"

}

setpassword() {
  [[ -z $1 ]] && echo -e "\x1B[91;1m[ERROR]\x1B[0m View the VM in VirtualBox to know the randomly generated password and set it with command set-password:\n  \x1B[92;1m$0 set-password <password>\x1B[0m\n" && exit 1
  echo "$1" > ./.password
}

ssh2server() {
  password=$(cat ./.password 2>/dev/null)
  [[ -z ${password} ]] && echo -e "\x1B[91;1m[ERROR]\x1B[0m View the VM in VirtualBox to know the randomly generated password and set it with command set-password:\n  \x1B[92;1m$0 set-password <password>\x1B[0m\n" && exit 1
  echo -e "Enter password: ${password}"
  # TODO: Pass password to ssh when it is possible to make connection to VM
  ssh root@10.0.2.15
}

while (( "$#" )); do
  case $1 in
    help)
      help
      ;;
    init)
      init
      ;;
    set-password)
      setpassword $2
      shift
      ;;
    ssh)
      ssh2server
      ;;
  esac
  shift
done
