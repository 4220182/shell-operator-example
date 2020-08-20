#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Pod
  executeHookOnEvent: ["Added"]
EOF
else
  echo "OnStartup Shell powered hook"
  podName=$(jq -r .[0].object.metadata.name $BINDING_CONTEXT_PATH)
  cat ${BINDING_CONTEXT_PATH} >/tmp/tmp-pod.json
  echo "New Pod '${podName}' added"
fi