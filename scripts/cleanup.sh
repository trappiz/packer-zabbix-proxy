#!/bin/bash
# Cleanup folders
rm -rf /root/.ansible
rm -rf /root/\~*
rm -rf /home/ubuntu/.ansible
rm -rf /home/ubuntu/\~*

# Cleaning up tmp
rm -rf /tmp/*

# Remove Bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/ubuntu/.bash_history

# Remove log files
find /var/log -type f -exec truncate --size=0 {} \;
