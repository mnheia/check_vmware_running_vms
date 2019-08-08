#! /bin/bash

#
# Simple script to count number of running VMs in ESXi environment and compare with what you think should be running
# count number of running VMs v1.0
#

# Exit codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

# Get desired number of VMs
desired_vms=$3
#echo $desired_vms

running_vms=$(ssh $1@$2 'esxcli vm process list | grep "Process ID" | wc -l')
#echo $running_vms

if [[ $running_vms -lt $desired_vms || $running_vms == 0  ]]; then
        echo "CRITICAL: Number of running VMs is $running_vms - less than desired |vms=$running_vms"
        exit $STATE_CRITICAL
elif [[ $running_vms -gt $desired_vms ]]; then
        echo "WARNING: Number of running VMs is $running_vms more than desired |vms=$running_vms"
        exit $STATE_WARNING
else
        echo "INFO: Number of running VMs is $running_vms - exactly as desired |vms=$running_vms"
        exit $STATE_OK
fi
