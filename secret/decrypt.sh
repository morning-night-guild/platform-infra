#!/bin/bash -ue

env=$1

secret=$2

if [[ ! -d secret/env/${env} ]]; then echo "secret/env/${env} not exists"; exit 1; fi

if [[ ! -e secret/env/${env}/${secret}.yaml ]]; then echo "secret/env/${env}/${secret}.yaml not exists"; exit 1; fi

sops --decrypt secret/env/${env}/${secret}.yaml > secret/env/${env}/${secret}.tmp.yaml

touch secret/env/${env}/${secret}.in.txt

yq ".data.${secret}" secret/env/${env}/${secret}.tmp.yaml | base64 -D > secret/env/${env}/${secret}.out.txt

rm secret/env/${env}/${secret}.tmp.yaml
