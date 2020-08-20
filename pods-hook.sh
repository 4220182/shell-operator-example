# 触发与挂钩相关的事件时，Shell-operator将在不带参数的情况下执行挂钩。
# 有关导致挂钩执行的事件的信息称为绑定上下文，并以JSON格式写入临时文件。
# 该文件的路径可通过环境变量挂接BINDING_CONTEXT_PATH。
# 临时文件具有唯一的名称，以防止队列之间发生冲突，并且在挂接运行后被删除。
#
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