#!/bin/bash


source ./vars.sh

for index in "${!fqdns[@]}"
do

run=$(($index + 1))

mkdir -p "${fqdns[$index]}";

cd "${fqdns[$index]}";

cp ../meta.cnf ./;

sed -i 's/##FQDN##/'"${fqdns[$index]}"'/g' meta.cnf

openssl genrsa -out entity.key 2048

openssl req -new -sha256 -nodes -key entity.key -config meta.cnf -out entity.csr

openssl x509 -req -in entity.csr -CA ../ca/root.crt -CAkey ../ca/root.key \
  -CAcreateserial -out entity.crt -days 500 -sha256 -extensions v3_req \
  -extfile meta.cnf;

cat entity.crt ../ca/root.crt > entity.full.crt;
cd ../

done
