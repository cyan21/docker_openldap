# OpenLdap in docker container 


## How to 

1. build image

```
$ git clone https://github.com/cyan21/docker_openldap.git
$ cd docker_openldap

# for ubuntu xenial 
$ docker build -t ych/openldap:0.1 -f ubuntu/Dockerfile .

# for centos7
$ docker build -t ych/openldap:0.1 -f centos7/Dockerfile .
```

2. run image

> you can use the /opt/openldap/scripts folder inside the container as a mount point and add your custom ldap scripts to execute them
```
$ mkdir /tmp/custom_scripts
$ docker run -itd -p 389:389 --mount type=bind,source=/tmp/custom_scripts,target=/opt/openldap/scripts/ ych/openldap:0.1
```

3. Init data 

```
$ docker exec <CONTAINER_ID> /init.sh
```

you can add your ldap scripts in /tmp/custom_scripts (host) and execute them in the container : 

```
$ cp ldap_script.ldif /tmp/custom_scripts/ 
$ docker exec <CONTAINER_ID> ldapadd -D  cn=Manager,dc=jfrog,dc=com -w jfrog -f /opt/openldap/scripts/ldap_script.ldif 
```



## Good to know 

* you can find a helper file in /memo_ldap.txt

```
$ docker exec <CONTAINER_ID> cat /memo_ldap.txt 
```

* Installation and feeding 

> done in 2 steps as I couldn't find a proper way to run my init script after the LDAP server is UP ...



* Customizations

ldap password 
running port

* To Do
use a variable for the password in the init.sh
