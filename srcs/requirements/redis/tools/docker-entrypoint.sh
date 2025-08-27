#!/usr/bin/env sh

# Exit on error
set -e

# Run redis
exec redis-server --requirepass $REDIS_PASSWORD
