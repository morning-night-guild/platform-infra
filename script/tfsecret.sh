#!/bin/bash -ue

secret=$1

if [[ -z "${secret}" ]]; then echo "please specify secret"; exit 1; fi

touch terraform/sops/${secret}.in.txt

touch terraform/sops/${secret}.out.txt
