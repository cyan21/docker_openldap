#!/bin/bash

ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/memberof.ldif
ldapadd -D  cn=Manager,dc=jfrog,dc=com -w jfrog -f /tmp/root.ldif
ldapadd -D  cn=Manager,dc=jfrog,dc=com -w jfrog -f /tmp/users.ldif
ldapadd -D  cn=Manager,dc=jfrog,dc=com -w jfrog -f /tmp/groupofnames.ldif

