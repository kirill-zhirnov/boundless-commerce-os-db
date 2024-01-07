#!/bin/bash
set -e

mv /root/pg_hba.conf /var/lib/postgresql/data

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    create database delivery;
    create database babylon_saas;
    create database babylon_sample;
    create user delivery_view with password '4mK5jdq3pT';
EOSQL

#tar -C /tmp -xzvf /root/delivery.tar.gz
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" delivery < /tmp/delivery.sql
#rm /tmp/delivery.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" delivery < /root/delivery.sql

# Grant access to delivery view:
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" delivery <<-EOSQL
    grant all privileges on all tables in schema public to delivery_view;
    grant all privileges on all sequences in schema public to delivery_view;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" babylon_saas < /root/saas.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" babylon_sample < /root/sample.sql
