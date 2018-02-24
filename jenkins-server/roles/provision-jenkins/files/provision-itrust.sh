#!/bin/sh
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i /home/ubuntu/CSC519DevOps-Project/inventory /home/ubuntu/CSC519DevOps-Project/itrust-server/main.yml
