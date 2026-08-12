#!/bin/bash

# Start SQL Server
sqlservr 2>&1 | tee /usr/local/log/server.log