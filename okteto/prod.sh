#!/bin/sh -eu

cp secret/env/prod/*.yaml charts/secret/templates/

helm upgrade --install --wait morning-night-dream-platform-secret ./charts/secret --namespace=morning-night-dreamer

helm upgrade --install --wait morning-night-dream-platform-database ./charts/database --namespace=morning-night-dreamer

helm upgrade --install --wait morning-night-guild-platform-app-core ./charts/app-core --namespace=morning-night-dreamer

helm upgrade --install --wait morning-night-guild-platform-app-api ./charts/app-api --namespace=morning-night-dreamer
