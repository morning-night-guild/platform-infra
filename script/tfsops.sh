#!/bin/bash -ue

cp terraform/sops/*.json tmp/

for secret in $(find tmp | grep json) ; do
    sops --decrypt --in-place ${secret}
done
