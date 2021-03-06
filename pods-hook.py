#!/usr/bin/env python

import sys
import os
import json

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
        with open(os.getenv('BINDING_CONTEXT_PATH'), 'r') as f:
            data = json.load(f)
            #print("new Pod ", data, " added")
            print("New Pod ", data[0]['object']['metadata']['name'], " added")
