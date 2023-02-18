#!/bin/bash -ue

chart=$1

secret=$2

key=age1jglwyzrn80auhq0k93mv8zqn5ezt6ngsdvhjn23nwfh0quq7wussn2tdm3

if [[ -z "${secret}" ]]; then echo "Please specify secret"; exit 1; fi

yq -i "(del.sops)" ./charts/${chart}/templates/secret/${secret}.yaml

yq -i ".data.${secret}=\"$(cat charts/${chart}/templates/secret/${secret}.in.txt | base64)\"" charts/${chart}/templates/secret/${secret}.yaml

sed -i .txt 's/"//g' charts/${chart}/templates/secret/${secret}.yaml

rm charts/${chart}/templates/secret/${secret}.yaml.txt

sops --encrypt \
	--age ${key} \
	--encrypted-regex '^(data|stringData)$$' \
	--in-place \
	charts/${chart}/templates/secret/${secret}.yaml

yamlfmt charts/${chart}/templates/secret/${secret}.yaml
