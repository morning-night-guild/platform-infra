#!/bin/bash -ue

sops --decrypt k8s/templates/secret/${secret}.yaml > k8s/templates/secret/${secret}.tmp.yaml

yq ".data.${secret}" k8s/templates/secret/${secret}.tmp.yaml | base64 -D > k8s/templates/secret/${secret}.out.txt

rm k8s/templates/secret/${secret}.tmp.yaml
