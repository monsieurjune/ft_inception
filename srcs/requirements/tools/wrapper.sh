#!/usr/bin/env bash

# Exit when error
set -e

# Load env
set -a
. $1 # env path (let makefile handle it)
set +a

# Run cmd
bash $2