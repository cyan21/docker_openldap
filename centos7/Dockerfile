FROM centos:7 

MAINTAINER Yann CHAYSINH <yannc@jfrog.com>
LABEL version="0.1"

ARG ldap_password=jfrog

USER root:root

RUN yum -y update && \
    yum -y -q install openldap migrationtools openldap-clients && \
    yum clean all

RUN echo "olcRootPW: `slappasswd -s ${ldap_password}`" >> /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif && \
    sed -i "s/my-domain/jfrog/g" /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif && \
    sed -i "s/my-domain/jfrog/g"  /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{1\}monitor.ldif && \
    cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG && \
    chown -R ldap:ldap /var/lib/ldap/


COPY ldap_scripts/centos7/memberof.ldif /tmp/ 
COPY ldap_scripts/root.ldif /tmp/ 
COPY ldap_scripts/users.ldif /tmp/ 
COPY ldap_scripts/groupofnames.ldif /tmp/ 
COPY entrypoint.sh / 
COPY init.sh / 
COPY memo_ldap.txt /

RUN chmod 755 /entrypoint.sh /init.sh

VOLUME ["/etc/openldap","/var/lib/ldap"]

EXPOSE 389

# 1st param is user and 2nd is log level
# http://www.openldap.org/doc/admin24/slapdconfig.html
ENTRYPOINT ["/entrypoint.sh","ldap", "32768"]

