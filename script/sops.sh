#!/bin/bash -ue

cp charts/secret/templates/*.yaml tmp/

for secret in $(find tmp | grep yaml) ; do
    sops --decrypt --in-place ${secret}
done
