#!/bin/bash -ue

secret=$1

cat << EOF > k8s/templates/secret/${secret}.yaml
apiVersion: v1
kind: Secret
metadata:
    name: platform-secret-${secret}
type: Opaque
data:
    ${secret}: ""
EOF

touch k8s/templates/secret/${secret}.in.txt

touch k8s/templates/secret/${secret}.out.txt
