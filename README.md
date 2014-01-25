Debian 7 based Vagrant LAMP VM
======

### What does this do?

This Vagrant VM is desgined for PHP development. It provides a LAMP stack with Apache, PHP and MySql. It also includes common utilities for modern PHP development such as Git for source code control and Composer for dependency management.

### What do I need to run this

- MacOS or Linux
- VirtualBox 4.3.6
- Vagrant 1.4.3

### What's included?

- Debian 7RC1 x64
- Apache 2.2.22
- MySQL 5.5.33
- PHP 5.4.4-14
- Curl 
- Git 1.7.10
- Composer 
- Sass 3.1.19
- Compass 

### How do I get up and running?

Create a new folder on your system where to pull down and install the VM.

Then clone this repo by running:

```
git clone git@github.com:mazamengr/dev-vm.git .
```

*Note: the ( . ) period character at the end of the line will force the git repo to be cloned in your current directory. Make sure that you are in the correct folder*

### Mapping a local folder into the Vagrant VM

By default the Vagrant VM maps to your /Users/user-name/Sites directory. If you do not have this directory, you should create it first as it will cause `vagrant up` to fail and the VM will not start.

You **MUST** at least change this in the `Vagrantfile` to your **user-name** as it is currently set to mine. Open the `Vagrantfile` in your favorite editor and change the path in the following line:

```
config.vm.synced_folder "/Users/waqas/Sites", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
```

to a folder on your local system. It doesn ot have to be your ~/Sites folder if you wish.

Once the repo has been cloned simply bring up the VM by running:

```
vagrant up
```

*Note: this may take a while as the first time the VM is > upped > it has to provision all the tools such as Apache, etc. If you don't understand what all these terms mean, don't worry. The VM will be up and running soon enough.*

Once the output has completed and you're returned back to the command prompt, the VM should be running.

You can double check this by typing `vagrant status` at the command prompt.

### Accessing the VM

You can log into the VM by running `vagrant ssh` at the command prompt. 

Once you're logged in, you can run composer to setup projects, use git etc.

### Shutting down the VM

To shut down, simply type `vagrant halt`.

Happy Developing!
