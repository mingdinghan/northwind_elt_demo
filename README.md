## Northwind Store ELT Demo

### Introduction
This is a demo project to create an ELT pipeline using Airbyte, DBT and Snowflake.

This makes use of the [Northwind Store](https://github.com/pthom/northwind_psql) example dataset and demonstrates the following:
- extract data and load into Snowflake as `raw` data tables using Airbyte
- use dimensional modeling and dbt to build `mart` data tables
- visualization using Preset


### Loading data into local Postgres as source database

- Use the `integration/source/northwind.sql` file to populate your localhost Postgres database
   ```bash
   $ psql -h localhost -d postgres

   postgres=# create database northwind_store
   postgres=# \c northwind_store
   postgres=# \q

   $ psql northwind_store < integration/source/northwind.sql
   $ psql -h localhost -d northwind_store
   ```

- Explore the data set
   ```sql
   select COUNT(*) FROM customers;
   select COUNT(*) FROM products;
   select COUNT(*) FROM orders;
   ```
