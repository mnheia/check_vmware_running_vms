Copyright (c) 2019, Mitja Sovec <mitja@sovec.si>

Contributors: Danilo Godec

# check_vmware_running_vms
A Nagios plugin to check number of running VMs on VMWare environment

# Example
## Server Side

You will need to define command:

```
define command {
        command_name            check_vmware_running_vms
        command_line            sshpass -p $_MONITORING_PASSWORD$ $USER1$/check_running_vms_vmware.sh $ARG1$ $ARG2$ $ARG3$
}
```

You will need to define service:

```
define service {
        service_description     RUNNING_VMS
        host_name               hostname
        use                     service-name
        check_command           check_vmware_running_vms!$_MONITORING_USER$!$HOSTADDRESS$!1
}
```

Where number of running VMs on SERVICE should be 1 - replace number with the number of VMs that should be running.

You will need to add a custom argument on 'host' definition:
```
monitoring_user       username
monitoring_password   password
```

## Client Side

### Requirements
- user for monitoring on VMWare side that is allowed of doing SSH
- ssh connection from monitoring server to ESXi server

# Bugs
Please report any bugs or feature requests through the web interface at https://github.com/mnheia/check_vmware_running_vms/issues
