# PuppetConf2016
Workspace and Virtual Environment for the PuppetConf 2016 Training (Practitioner Training)

## Make script
This script is to make all the required actions during the PuppetConf 2016 training.

As PuppetConf just provided an OVA file with CentOS 6.8 and no more information, this script simulate Vagrant with the basic commands (init, up, ssh, halt and destroy). Once we know the future of this VM or how are we going to use it, this script may be replaced by Vagrant later using the subcommand `box` of `make`

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
* __box__: Create a Vagrant box from the Student VM.

### Examples

The basic workflow is:

    ./make init
    ./make set-password random.password
    ./make ssh
    ./make halt
    ./make up

Once the new Student VM is fully configured (_instructions should be provided in the training_), the VM can be used to create a Vagrant box using the subcommand `box`

    ./make box

Now you can use Vagrant as usual and (recommended) upload it to Vagrant Enterprise (https://atlas.hashicorp.com/vagrant)

    vagrant box list
    vagrant up
    vagrant status
    vagrant ssh
    vagrant halt
    vagrant destroy

And, execute the command `destroy` to remove the initial Student VM, if not required during the training.

    ./make destroy

Or, destroy the new Vagrant box with `unbox`

    ./make unbox

Other option is to clean it all (`unbox` and `destroy`) with `clean`

    ./make clean

## TODO

[ ] The ssh to the VM is not working. Waiting for the training to know what to do. Once it is known, pass the password to ssh or generate an ssh key (like vagrant)
[ ] Create the same commands for Docker.
