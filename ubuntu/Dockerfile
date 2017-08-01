FROM ubuntu:16.04

MAINTAINER Yann CHAYSINH <yannc@jfrog.com>
LABEL version="0.1"

ARG ldap_password=jfrog

USER root:root

# slapd package requires to set the password during the installation, LC_ALL=C DEBIAN_FRONTEND=noninteractive will skip this step
RUN apt-get -y update && \
    LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y -q install slapd ldap-utils && \
    apt-get clean all

# set up config
RUN sed -i "s/olcRootPW:: \(.*\)/olcRootPW: `slappasswd -s ${ldap_password}`/" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
    sed -i "s/nodomain/jfrog,dc=com/g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
    sed -i "s/cn=admin/cn=Manager/g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
    chown -R openldap:openldap /var/lib/ldap/

# clean up config file ... NO BLANK line or you'll get an invalid credentials with ldapadd !!!
#RUN sed -i "s/^ e//g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
#    sed -i "s/ non/ none/g" /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
#    mv /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif /tmp && \
#    grep "[a-z]" /tmp/olcDatabase\=\{1\}mdb.ldif > /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif && \
#    chown openldap:openldap /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}mdb.ldif

COPY ldap_scripts/ubuntu/memberof.ldif /tmp/ 
COPY ldap_scripts/root.ldif /tmp/ 
COPY ldap_scripts/users.ldif /tmp/ 
COPY ldap_scripts/groupofnames.ldif /tmp/ 
COPY entrypoint.sh / 
COPY init.sh / 
COPY memo_ldap.txt /

RUN chmod 755 /entrypoint.sh /init.sh

VOLUME ["/etc/ldap","/var/lib/ldap"]

EXPOSE 389

# 1st param is user and 2nd is log level
# http://www.openldap.org/doc/admin24/slapdconfig.html
ENTRYPOINT ["/entrypoint.sh","openldap", "32768"]

