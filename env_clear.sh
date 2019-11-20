#!/bin/bash

nova list | egrep 'app.|mon.' | awk '{print $2}' | while read i
do
	nova delete $i
done
sleep 6
neutron security-group-delete twitter-app
sleep 6
openstack floating ip delete $(openstack floating ip list | grep ' | ' | grep -v ' ID ' | awk '{print $4}' | xargs)
