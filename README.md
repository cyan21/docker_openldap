# OpenLdap in docker container

## How to

1. run image

```bash
podman run -d \
    --name openldap \
    -p 1389:1389 \
    -e BITNAMI_DEBUG=true \
    -e LDAP_ROOT=dc=jfrog,dc=com \
    -e LDAP_CUSTOM_LDIF_DIR=/my_custom_ldifs \
    -v ~/data:/my_custom_ldifs:Z \
    -v ~/data/modules/memberof.ldif:/opt/bitnami/openldap/etc/schema/memberof.ldif:Z \
bitnami/openldap:2.5.11
```

2. Init data 

```bash
for ldif in `ls data/*.ldif`; do 
    podman cp $ldif openldap:/my_custom_ldifs/
    echo "[INFO] executing $ldif ..."
    podman exec -ti openldap -- ldapadd -H 'ldapi:///' -D "cn=admin,dc=jfrog,dc=com" -w adminpassword -x  -f my_custom_ldifs/$ldif  
done

```

> you can add your ldap scripts in the data folder (host) and execute them as above
> see the helper file in /memo_ldap.txt