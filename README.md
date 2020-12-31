# ansible-tutorial-gcp
##ANSIBLE

##What is ansible?

Ansible is a configuration automation platform that is easy to use and makes initialization and configuration of machines simple, replicable and scalable.

##How it works?
Ansible in essence SSH’s into your machines and performs changes to the os configuration as defined by your ansible playbook written in YAML.

##How to set it up?
Simply create an SSH key on your host machine and add the public key to the project wide metadata. 

You also need to install the latest version of ansible, the easiest way I found to do so is to use the PIP method in ansible install playbook. It installs globally the latest version every time. I’ve had issues with the apt method.

##What is an inventory?
Ansible manages machines it has authority over using something called an inventory.( as shown below) the inventory is a file, written in yaml that defines how the machines are defined and coordinated. As an example, below I have an inventory file, that’s a learning project I created configuring and installing a LAMP server in ansible. There is a groups section this defines my lamp server from my testing client. 

Below I am going to show a GCP dynamic inventory which is what I use because of its scalability and automation

In order to configure the dynamic inventory you need to go and modify the /etc/ansible/ansible.cfg 

Modify the lines

Under defaults ([defaults])
Add the lines:
inventory = <path to the inventory file>
enable_plugins = host_list, virtualbox, yaml, constructed, gcp_compute

Here is a basic inventory and its output:

The inventory below will only list instances in a certain zone:

I added the zone parameter, as you can see, now there are only 3 IP’s this means that these 3 IP’s represent machines in those zones.
Next I will change the inventory so that it identifies instances by their hostnames and not their IP’s

And the beautiful thing about dynamic inventory is that it’s dynamic, so if I were to add a new instance in us-west1-a then there will be a new instance as shown in the screenshot below.

Lastly, I will demonstrate how to group instances together to perform ansible actions on multiple machines at once:


If you look above I have created 2 groups; lamp servers and lamp projects. With these two groups I can direct an action performed by ansible to any of these groups and the actions performed will be performed in all instances in the group.

##The playbook.

A playbook is the actions that should be performed on the machines. It’s written in YAML so its really easy to figure out, you can even write your own yaml modules in python for your use case.

I am not going to deep dive into a specific playbook for this given that every playbook is different and that there are multiple ways of deploying a playbook. I will link my playbook for creating a LAMP stack and mysql client in this github so that you can play with it

##Paybook in general

The easiest way to create a playbook is to lookup a quickstart guide and write out all the steps in YAML. Ansible will then perform every step in that playbook one at the time and on multiple machines. You can then add your own configurations depending on your needs.
