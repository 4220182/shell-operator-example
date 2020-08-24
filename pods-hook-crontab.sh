#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
schedule:
- name: "every 2 min"
  crontab: "*/2 * * * *"
  allowFailure: true
EOF
else
  echo "TEST Start"
  binding=$(cat $BINDING_CONTEXT_PATH)
  echo "TEST Message from 'schedule' hook with 6 fields crontab: $binding"
  echo "TEST End"
fi
