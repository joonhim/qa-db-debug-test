#!/bin/bash
set -e
# Start PostgreSQL service
PG_VER=$(ls /etc/postgresql/ | head -n1)
pg_ctlcluster --skip-systemctl-redirect "$PG_VER" main start
trap 'pg_ctlcluster --skip-systemctl-redirect "$PG_VER" main stop' EXIT
# (Optional but tiny) wait briefly so tests don’t race the DB
pg_isready -q || sleep 0.5
# Run the test
npx mocha test_database.js
