#!/bin/bash -ue

chart=$1

secret=$2

cat << EOF > charts/${chart}/templates/secret/${secret}.yaml
apiVersion: v1
kind: Secret
metadata:
    name: platform-secret-${secret}
type: Opaque
data:
    ${secret}: ""
EOF

touch charts/${chart}/templates/secret/${secret}.in.txt

touch charts/${chart}/templates/secret/${secret}.out.txt
