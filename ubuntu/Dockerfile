FROM ubuntu:16.04

MAINTAINER Yann CHAYSINH <yannc@jfrog.com>
LABEL version="0.1"

ARG ldap_password=jfrog

USER root:root

RUN apt-get -y update && \
    apt-get -y -q install openldap ldap-utils && \
    apt-get clean all

RUN echo "olcRootPW: `slappasswd -s ${ldap_password}`" >> /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
    sed -i "s/my-domain/jfrog/g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
    chown -R ldap:ldap /var/lib/ldap/


COPY ldap_scripts/ubuntu/memberof.ldif /tmp/ 
COPY ldap_scripts/root.ldif /tmp/ 
COPY ldap_scripts/users.ldif /tmp/ 
COPY ldap_scripts/groupofnames.ldif /tmp/ 
COPY entrypoint.sh / 
COPY init.sh / 
COPY /memo_ldap.txt /

RUN chmod 755 /entrypoint.sh /init.sh

VOLUME ["/etc/ldap","/var/lib/ldap"]

EXPOSE 389

ENTRYPOINT ["/entrypoint.sh"]

