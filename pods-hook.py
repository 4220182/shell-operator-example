#!/usr/bin/env python

import sys
import os

if __name__ == "__main__":
    if len(sys.argv)>1 and sys.argv[1] == "--config":
        config = '''
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Pod
  executeHookOnEvent: ["Added"]        
'''
        print(config)
    else:
        print("OnStartup Python powered hook")
        print("env: ", os.getenv('BINDING_CONTEXT_PATH'))