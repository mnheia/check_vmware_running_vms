#! /bin/bash

#
# Simple script to count number of running VMs in ESXi environment and compare with what you think should be running
# count number of running VMs v1.1
#

# Exit codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

# Get desired number of VMs
desired_vms=$3
#echo $desired_vms

# Create temp file for data storage
tmp_file=$(mktemp -u)

# Connect to remote host and save data in tmp_file - temp file for data storage
ssh $1@$2 'esxcli vm process list' | grep "Display Name:" | sed 's/.*Display Name://g' > ${tmp_file}

# Count number of VMs in tmp_file
count_vms=$(wc -l ${tmp_file} | awk '{print $1}')
#echo $count_vms

# Display running VMs in tmp_file
display_vms=$(cat ${tmp_file} | tr '\n' ' ')

if [[ $count_vms -lt $desired_vms || $count_vms == 0  ]]; then
        echo "CRITICAL: Number of running VMs is $count_vms - less than desired. Running VMs: $display_vms |vms=$count_vms"
        rm -f ${tmp_file}
        exit $STATE_CRITICAL
elif [[ $count_vms -gt $desired_vms ]]; then
        echo "WARNING: Number of running VMs is $count_vms more than desired. Running VMs: $display_vms |vms=$count_vms"
        rm -f ${tmp_file}
        exit $STATE_WARNING
else
        echo "INFO: Number of running VMs is $count_vms - exactly as desired. Running VMs: $display_vms |vms=$count_vms"
        rm -f ${tmp_file}
        exit $STATE_OK
fi
