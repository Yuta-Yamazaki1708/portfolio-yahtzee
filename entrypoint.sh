#!/bin/bash
set -e

rm -f /yahtzee/tmp/pids/server.pid

exec "$@"
