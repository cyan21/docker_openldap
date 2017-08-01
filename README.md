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

```
$ docker run -itd -p 389:389 ych/openldap:0.1
```

3. Init data 

```
$ docker exec <CONTAINER_ID> /init.sh
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
volume

* To Do
use a variable for the password in the init.sh
