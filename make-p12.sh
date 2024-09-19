#!/bin/bash

source ./vars.sh

storepass='elastic'

keytool -storepass $storepass -import -alias ca -file ca/root.crt -keystore ca/root.p12 -deststoretype PKCS12

for index in "${!fqdns[@]}"
do

cd "${fqdns[$index]}";

# Make entity.p12 file
openssl pkcs12 -in entity.crt -inkey entity.key -name "${fqdns[$index]}" -export -out entity.p12

# Merge the root.p12 to the entity.p12 file
keytool -importkeystore -srckeystore ../ca/root.p12 -srcstoretype pkcs12 -srcstorepass $storepass -destkeystore entity.p12 -deststoretype pkcs12 -deststorepass $storepass

cd ../

done
