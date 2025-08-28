#!/usr/bin/env sh

# Exit on error
set -e

# ping
exec redis-cli -h 127.0.0.1 -p 6379 -a "${REDIS_PASSWORD}" ping
