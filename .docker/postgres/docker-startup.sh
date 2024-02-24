#!/bin/bash
set -e

mv /root/pg_hba.conf /var/lib/postgresql/data

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	create database delivery;
	create database babylon_saas;
	create database babylon_sample;
EOSQL

#tar -C /tmp -xzvf /root/delivery.tar.gz
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" delivery < /tmp/delivery.sql
#rm /tmp/delivery.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" delivery < /root/delivery.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" babylon_saas < /root/saas.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" babylon_sample < /root/sample.sql
