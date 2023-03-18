#!/bin/bash -ue

secret=$1

if [[ -z "${secret}" ]]; then echo "please specify secret"; exit 1; fi

cat << EOF > charts/secret/templates/${secret}.yaml
apiVersion: v1
kind: Secret
metadata:
  name: platform-secret-${secret}
type: Opaque
data:
  ${secret}: ""
EOF

touch charts/secret/templates/${secret}.in.txt

touch charts/secret/templates/${secret}.out.txt
