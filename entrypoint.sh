#!/bin/bash

# Start SQL Server
sqlservr 2>&1 | tee /sql/server.log