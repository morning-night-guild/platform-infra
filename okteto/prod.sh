#!/bin/sh -eu

helm upgrade --install morning-night-guild-platform ./charts/platform --namespace=morning-night-dreamer

helm upgrade --install --wait morning-night-guild-platform-app-core ./charts/app-core --namespace=morning-night-dreamer

helm upgrade --install --wait morning-night-guild-platform-app-api ./charts/app-api --namespace=morning-night-dreamer
