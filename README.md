# PuppetConf2016
Workspace and Virtual Environment for the PuppetConf 2016 Training (Practitioner Training)

## Make script
This script is to make all the required actions during the PuppetConf 2016 training.

As PuppetConf just provided an OVA file with CentOS 6.8 and no more information, this script simulate Vagrant with the basic commands (init, up, ssh, halt and destroy). Once we know the future of this VM or how are we going to use it, this script may be replaced by Vagrant.

### Use:

    ./make <command> <parameters>

### Available commands are:

* __help__: Print this help
* __init__: Initialize the environment for the PuppetConf. Download and run the student VM
* __set-password__: Set the randomly generated password in the student VM
* __ssh__: SSH to the Student VM
* __halt__: Stop (poweroff) the Student VM. To start it up, use the command: up
* __up__: StartUp the Student VM. It startup the VM after using the command: halt
* __destroy__: Terminate and delete the Student VM. To have it back again, use the command: init
