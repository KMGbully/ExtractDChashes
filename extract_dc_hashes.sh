#!/bin/bash
# Extract passwords from the domain controller for auditing
# Kevin Gilstrap, 12-15-2017
#
#  chmod +x extract_dc_hashes.sh
#  Usage:  ./extract_dc_hashes.sh 
#
clear
echo -n "Enter domain name:  "
read domain
echo " "
echo -n "Enter username:  "
read username
echo " "
echo -n "Enter password:  "
read passwd
echo " "
echo -n "Enter IP address of domain controller:  "
read ip
echo " "
echo "Extracting hashes..."
crackmapexec -t 1 -u $username -p $passwd -d $domain --ntds drsuapi --ntds-history --ntds-pwdLastSet $ip | tee -a $domain_hashes_cmexec
if [[ -f $domain_hashes_cmexec ]]; then
  echo " "
  echo Completed extracting hashes.  Output saved to $domain_hashes_cmexec
  exit 0
else
  echo " "
  echo "Failed to output hashes.  Confirm settings and try again."
  exit 0
fi
