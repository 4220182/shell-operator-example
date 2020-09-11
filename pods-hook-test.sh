#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- name: OnCreateDeletePod
  apiVersion: v1
  kind: horizontalpodautoscalers
  executeHookOnEvent:
  - Added
  - Deleted
- name: OnModifiedPod
  apiVersion: v1
  kind: horizontalpodautoscalers
  executeHookOnEvent:
  - Modified
EOF
else
  echo "TEST Start"

  type=$(jq -r '.[0].type' $BINDING_CONTEXT_PATH)
  bindingName=`jq -r ".[$IND].binding" $BINDING_CONTEXT_PATH`
  resourceEvent=$(jq -r '.[0].watchEvent' $BINDING_CONTEXT_PATH)
  resourceName=$(jq -r '.[0].object.metadata.name' $BINDING_CONTEXT_PATH)

  echo "TEST type: '${type}'"
  echo "TEST bindingName: '${bindingName}'"
  echo "TEST resourceEvent: '${resourceEvent}'"
  echo "TEST resourceName: '${resourceName}'"
  cat $BINDING_CONTEXT_PATH >/tmp/context.json

  if [[ $type == "Event" ]] ; then
    podName=$(jq -r '.[0].object.metadata.name' $BINDING_CONTEXT_PATH)
    echo "Pod '${podName}' added"
  fi
  echo "TEST End"
fi
