#!/bin/bash

chmod -R 600 /root/.ssh
eval "$(ssh-agent -s)"

exec /entrypoint "$@"
