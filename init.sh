#!/bin/bash

terraform init
terraform apply -auto-approve

ansible-playbook -i inventory.ini main.yaml -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"