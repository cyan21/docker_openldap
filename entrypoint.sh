#!/bin/bash

ulimit -n 1024 && /usr/sbin/slapd -u $1 -h "ldap:/// ldapi:///" -d $2 

