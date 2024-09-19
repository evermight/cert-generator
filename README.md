
# Cert Tool


1. Run `./make-root.sh` to make your CA files. They will output to the `./ca` directory.

2. Run `./make-entities.sh` to make entity certs that are signed by the CA from step 1.  They will output to individual directories within `./`.


# Make P12 Files

Answer from here: https://stackoverflow.com/questions/42766935/creating-p12-truststore-with-openssl
Note that you need the `2.16.840.1.113894.746875.1.1: <Unsupported tag 6>`

Example command

```
# Make CA pkcs12 file
keytool -storepass 'elastic' -import -alias ca -file ca/root.crt -keystore ca/root.p12 -deststoretype PKCS12

# Make entity.p12 file
openssl pkcs12 -in node1.evermight.net/entity.crt -inkey node1.evermight.net/entity.key -name node1.evermight.net -export -out node1.evermight.net/entity.p12

# Merge the root.p12 to the entity.p12 file
keytool -importkeystore -srckeystore ca/root.p12 -srcstoretype pkcs12 -srcstorepass 'elastic' -destkeystore node1.evermight.net/entity.p12 -deststoretype pkcs12 -deststorepass 'elastic'
```


# Read P12 Files


Example command

```
openssl pkcs12 -info -in ca/root.p12 -nokeys
openssl pkcs12 -info -in node1.evermight.net/entity.p12 -nokeys
openssl pkcs12 -info -in node2.evermight.net/entity.p12 -nokeys
```
