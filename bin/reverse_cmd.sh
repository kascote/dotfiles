#!/bin/bash
SSH_OPTIONS="-S none"
# Always assume initial connection will be successful
export AUTOSSH_GATETIME=0
# Disable echo service, relying on SSH exiting itself
export AUTOSSH_PORT=0
#
# -f hace que funcione como daemon
#autossh -f -- $SSH_OPTIONS -o 'ControlPath none' -R 19999:localhost:22 sourceuser@138.47.99.99 -fN
#autossh -- $SSH_OPTIONS -o 'ControlPath none' -R 19999:localhost:22 sourceuser@138.47.99.99 -fN
autossh -- $SSH_OPTIONS -R 19999:localhost:22 cmd -fN
