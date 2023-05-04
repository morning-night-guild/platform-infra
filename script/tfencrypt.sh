#!/bin/bash -ue

key=age1q0zz464rdkt2wc2sq6ejwj22vwe660d0skc3clwpz88gcmf3930qwzchdw

secret=$1

if [[ ! -e terraform/sops/${secret}.in.txt ]]; then echo "terraform/sops/${secret}.in.txt not exists"; exit 1; fi

sops --encrypt \
	 --age ${key} \
	terraform/sops/${secret}.in.txt > terraform/sops/${secret}.json.tmp

cat terraform/sops/${secret}.json.tmp | jq . > terraform/sops/${secret}.enc.json

rm terraform/sops/${secret}.json.tmp
