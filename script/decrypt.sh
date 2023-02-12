#!/bin/bash -ue

chart=$1

secret=$2

sops --decrypt charts/${chart}/templates/secret/${secret}.yaml > charts/${chart}/templates/secret/${secret}.tmp.yaml

yq ".data.${secret}" charts/${chart}/templates/secret/${secret}.tmp.yaml | base64 -D > charts/${chart}/templates/secret/${secret}.out.txt

rm charts/${chart}/templates/secret/${secret}.tmp.yaml
