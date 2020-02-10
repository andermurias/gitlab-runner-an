#!/bin/bash

chmod -R 600 /root/.ssh

exec /entrypoint "$@"