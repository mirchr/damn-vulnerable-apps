#!/bin/sh
set -e

if [ -z "${FLAG}" ]; then
    echo "ERROR: FLAG environment variable is required but not set." >&2
    echo "Start the container with: docker run -e FLAG=... ..." >&2
    exit 1
fi

printf '%s' "${FLAG}" > /flag.txt
chmod 644 /flag.txt
unset FLAG

exec "$@"
