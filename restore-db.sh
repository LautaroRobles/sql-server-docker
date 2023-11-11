#!/bin/bash

cd /sql

sqlcmd -U sa -P Password1234 -S localhost -Q "CREATE DATABASE GD2C2023"
sqlcmd -U sa -P Password1234 -S localhost -i gd_esquema.Schema.sql,gd_esquema.Maestra.sql,gd_esquema.Maestra.Table.sql -a 32767 2>&1 | tee restore.log