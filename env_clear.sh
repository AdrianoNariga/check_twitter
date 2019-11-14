#!/bin/bash
domain_var=$(grep ^domain playbooks/group_vars/all.yml | awk '{print $2}')

nova list | grep $domain_var | awk '{print $2}' | while read i
do
	nova delete $i
done
sleep 4
neutron security-group-delete twitter-app
