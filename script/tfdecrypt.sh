#!/bin/bash -ue

secret=$1

if [[ ! -e terraform/sops/${secret}.enc.json ]]; then echo "terraform/sops/${secret}.enc.json not exists"; exit 1; fi

sops --decrypt terraform/sops/${secret}.enc.json > terraform/sops/${secret}.tmp.json

touch terraform/sops/${secret}.in.txt

cat terraform/sops/${secret}.tmp.json | jq .data | tr -d '"' > terraform/sops/${secret}.out.txt

rm terraform/sops/${secret}.tmp.json
