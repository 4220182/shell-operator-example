#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Pod
  executeHookOnEvent:
  - Added
EOF
else
  echo "TEST Start"
  type=$(jq -r '.[0].type' $BINDING_CONTEXT_PATH)
  cat $BINDING_CONTEXT_PATH >/tmp/context.json
  if [[ $type == "Event" ]] ; then
    podName=$(jq -r '.[0].object.metadata.name' $BINDING_CONTEXT_PATH)
    echo "Pod '${podName}' added"
  fi
  echo "TEST End"
fi
