#!/bin/bash -ue

secret=$1

key=age1jglwyzrn80auhq0k93mv8zqn5ezt6ngsdvhjn23nwfh0quq7wussn2tdm3

if [[ -z "${secret}" ]]; then echo "Please specify secret"; exit 1; fi

yq -i "(del.sops)" ./k8s/templates/secret/${secret}.yaml

yq -i ".data.${secret}=\"$(cat k8s/templates/secret/${secret}.in.txt | base64)\"" k8s/templates/secret/${secret}.yaml

sed -i .txt 's/"//g' k8s/templates/secret/${secret}.yaml

rm k8s/templates/secret/${secret}.yaml.txt

sops --encrypt \
	--age ${key} \
	--encrypted-regex '^(data|stringData)$$' \
	--in-place \
	k8s/templates/secret/${secret}.yaml

yamlfmt k8s/templates/secret/${secret}.yaml
