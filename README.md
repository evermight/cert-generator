
# Cert Tool


1. Run `./make-root.sh` to make your CA files. They will output to the `./ca` directory.

2. Run `./make-entities.sh` to make entity certs that are signed by the CA from step 1.  They will output to individual directories within `./`.


# Make P12 Files

Example command

```
openssl pkcs12 -export -out ca/root.p12 -inkey ca/root.key -in ca/root.crt
openssl pkcs12 -export -out node1.evermight.net/entity.p12 -inkey node1.evermight.net/entity.key -in node1.evermight.net/entity.crt
openssl pkcs12 -export -out node2.evermight.net/entity.p12 -inkey node2.evermight.net/entity.key -in node2.evermight.net/entity.crt

```

# Read P12 Files


Example command

```
openssl pkcs12 -info -in ca/root.p12 -nokeys
openssl pkcs12 -info -in node1.evermight.net/entity.p12 -nokeys
openssl pkcs12 -info -in node2.evermight.net/entity.p12 -nokeys
```
