#!/bin/bash
rm -f tmp/pids/server.pid
bin/rails db:prepare
bin/rails server -b 0.0.0.0
