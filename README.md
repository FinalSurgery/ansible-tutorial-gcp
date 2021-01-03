# ansible-tutorial-gcp
## ANSIBLE

## What is ansible?

Ansible is a configuration automation platform that is easy to use and makes initialization and configuration of machines simple, replicable and scalable.

## How it works?
Ansible in essence SSH’s into your machines and performs changes to the os configuration as defined by your ansible playbook written in YAML.

## How to set it up?
Simply create an SSH key on your host machine and add the public key to the project wide metadata. 

You also need to install the latest version of ansible, the easiest way I found to do so is to [use the PIP method in ansible install playbook](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-with-pip). It installs globally the latest version every time. I’ve had issues with the apt method. For me it installed a very old version causing some issues with the newer features.

## What is an inventory?
Ansible manages machines, to manage the machines you need to identify them and group them so that actions can be performed on a large scale. This is done through an inventory, for the majority of ansible inventories are static, GCP and other clouds provide configurations for how to create a dynamic inventory. A dynamic inventory adds and substracts machines depending on their availbility. In this example I create two VM's in terraform and classify them in an inventory, the playbook is then ran which installs a LAMP stack on one machine and installs mysql client on another to test the connectivity of the LAMP stack and the existance of the database on the separate hard drive.

Below I will detail how the inventory work, I will briefly touch the playbook but creating ansible playbooks are extremly simple to create.

In order to configure the dynamic inventory you need to go and modify the /etc/ansible/ansible.cfg 

## configurations for GCP dynamic inventory.
Modify the lines

Under defaults ([defaults])
Add the lines:
inventory = <path to the inventory file>
enable_plugins = host_list, virtualbox, yaml, constructed, gcp_compute

## inventory step by step configuration.

Here is a basic inventory and its output:
![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/inventory_all.png)

The inventory below will only list instances in a certain zone:
![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/inventory_zone.png)

I added the zone parameter, as you can see, now there are only 3 IP’s this means that these 3 IP’s represent machines in those zones.
Next I will change the inventory so that it identifies instances by their hostnames and not their IP’s
![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/inventory_name.png)
And the beautiful thing about dynamic inventory is that it’s dynamic, so if I were to add a new instance in us-west1-a then there will be a new instance as shown in the screenshot below.
![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/inventory_name_added_instance.png)
Lastly, I will demonstrate how to group instances together to perform ansible actions on multiple machines at once:
![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/inventory_keyed_groups.png)

If you look above I have created 2 groups; lamp servers and lamp projects. With these two groups I can direct an action performed by ansible to any of these groups and the actions performed will be performed in all instances in the group.

## The playbook.

A playbook is the actions that should be performed on the machines. It’s written in YAML so its really easy to figure out, the way I figure out how to design a playbook is generally by looking up the steps required to setup a particular configuration and separating the setup in individual steps. I then lookup how to perform each steps in the context of ansible.

here is an example of the equivalent of using apt-get install apache2, making the necessary configuration for it to be online and responding to curls and then restarting the service.

![](https://github.com/FinalSurgery/ansible-tutorial-gcp/blob/main/images/ansible_playbook_example.png)

this is a farely easy example of a configuration. I have included an example of installing and configuring a lamp server and a server client for testing. in order to set up and run the example you should refer to Dany's terraform tutorial to deploy the instances in your project or simply create two instances that match the names in the screenshots above.




## Paybook in general

The easiest way to create a playbook is to lookup a quickstart guide and write out all the steps in YAML. Ansible will then perform every step in that playbook one at the time and on multiple machines. You can then add your own configurations depending on your needs.
