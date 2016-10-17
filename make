#!/usr/bin/env bash

# IP of the Student VM
IP='10.0.2.15'
BOXNAME='johandry/puppetconf-2016-student'

help() {
  cat <<'EOH'
Script to make all the required actions during the PuppetConf 2016 training.

As PuppetConf just provided an OVA file with CentOS 6.8 and no more information, this script
simulate Vagrant with the basic commands (init, up, ssh, halt and destroy). Once we know
how are we going to use it, this script may be replaced by Vagrant.

Use:
    ./make <command> <parameters>

Available commands are:
  help:         Print this help
  init:         Initialize the environment for the PuppetConf. Download and run the student VM
  set-password: Set the randomly generated password in the student VM
  ssh:          SSH to the Student VM
  halt:         Stop (poweroff) the Student VM. To start it up, use the command: up
  up:           StartUp the Student VM. It startup the VM after using the command: halt
  destroy:      Terminate and delete the Student VM. To have it back again, use the command: init
  box:          Make a vagrant box from the Student VM. Wait for the training if it is required to have something on the VM.
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
  ssh root@${IP}
}

halt() {
  if ! VBoxManage list runningvms | grep -q student
  then
    echo -e "\x1B[91;1m[ERROR]\x1B[0m Student VM is not running or does not exists"
    exit 1
  fi
  VBoxManage controlvm student poweroff
  VBoxManage list runningvms | grep -q student || echo -e "\x1B[92;1mPuppetConf 2016 Student VM was \x1B[91;1mpowered off\x1B[0m"
}

up() {
  if VBoxManage list runningvms | grep -q student
  then
    echo -e "\x1B[91;1m[ERROR]\x1B[0m Student VM is running"
    exit 1
  fi
  VBoxManage startvm student
  VBoxManage list runningvms | grep -q student || echo -e "\x1B[92;1mPuppetConf 2016 Student VM was \x1B[91;1mpowered off\x1B[0m"
}

destroy() {
  if ! VBoxManage list vms | grep -q student
  then
    echo -e "\x1B[91;1m[ERROR]\x1B[0m Student VM does not exists"
    exit 1
  fi
  VBoxManage unregistervm student --delete
  VBoxManage list vms | grep -q student || echo -e "\x1B[92;1mPuppetConf 2016 Student VM was \x1B[91;1mdestroyed\x1B[0m"
}

box(){
  mkdir -p boxes

  [[ ! -e ./boxes/PuppetConf2016Student.box ]] && \
    vagrant package --base student && \
    mv package.box boxes/PuppetConf2016Student.box

  vagrant box list | grep -q ${BOXNAME} || \
    vagrant box add ${BOXNAME} ./boxes/PuppetConf2016Student.box

  vagrant box list | grep -q ${BOXNAME} && \
    echo -e "\x1B[92;1mVagrant Box PuppetConf 2016 Student was added and is ready to use\x1B[0m"
}

unbox(){
  if ! vagrant box list | grep -q ${BOXNAME}
  then
    echo -e "\x1B[91;1m[ERROR]\x1B[0m Vagrant Box for PuppetConf Student does not exists"
    exit 1
  fi

  vagrant destroy -f

  vagrant box list | grep -q ${BOXNAME} && \
    vagrant box remove ${BOXNAME}

  rm -f ./boxes/PuppetConf2016Student.box

  vagrant box list | grep -q ${BOXNAME} || \
    echo -e "\x1B[92;1mVagrant Box PuppetConf 2016 Student was \x1B[91;1mremoved\x1B[92;1m and box file \x1B[91;1mdeleted\x1B[0m"
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
    halt)
      halt
      ;;
    up)
      up
      ;;
    destroy)
      destroy
      ;;
    box)
      box
      ;;
    unbox)
      unbox
      ;;
    clean)
      unbox
      destroy
      ;;
    *)
      echo -e "\x1B[91;1m[ERROR]\x1B[0m Command $1 is not defined. Try with command: help"
      exit 1
      ;;
  esac
  shift
done
