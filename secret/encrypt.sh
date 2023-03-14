#!/bin/bash -ue

key=age1jglwyzrn80auhq0k93mv8zqn5ezt6ngsdvhjn23nwfh0quq7wussn2tdm3

env=$1

secret=$2

if [[ ! -d secret/env/${env} ]]; then echo "secret/env/${env} not exists"; exit 1; fi

if [[ ! -e secret/env/${env}/${secret}.yaml ]]; then echo "secret/env/${env}/${secret}.yaml not exists"; exit 1; fi

yq -i "(del.sops)" ./secret/env/${env}/${secret}.yaml

yq -i ".data.${secret}=\"$(cat secret/env/${env}/${secret}.in.txt | base64)\"" secret/env/${env}/${secret}.yaml

sed -i .txt 's/"//g' secret/env/${env}/${secret}.yaml

rm secret/env/${env}/${secret}.yaml.txt

sops --encrypt \
	 --age ${key} \
	 --encrypted-regex '^(data|stringData)$$' \
	 --in-place \
	 secret/env/${env}/${secret}.yaml

yamlfmt secret/env/${env}/${secret}.yaml
