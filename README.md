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

### Using Airbyte

- Download Airbyte and run it locally
  ```bash
  docker-compose up
  ```
- Access the local Airbyte UI at `localhost:8080`
- Create a source `northwind_store_pg` for the postgresql database `northwind_store`
  - Host `host.docker.internal`
  - Update method `Detect Changes with Xmin System Column`
- Create a destination `northwind_store_dw_snowflake` for the Snowflake database `NORTHWIND_STORE_DW`
- Create a connection between `northwind_store_pg` and `northwind_store_dw_snowflake`
  - Namespace Custom Format: `raw`

  ![images/airbyte_connections_schema.png](images/airbyte_connections_schema.png)
  ![images/airbyte_connections_sync_completed.png](images/airbyte_connections_sync_completed.png)

### Using Snowflake

- Log in to Snowflake
- Go to `worksheets` > `+ worksheet`
- On the top right, select the role `ACCOUNTADMIN.XSMALL_WH`
- On the top left of the worksheet, select `NORTHWIND_STORE_DW.RAW`
- Query one of the synced tables from Airbyte e.g. `select * from customers`
![images/snowflake_data_loaded.png](images/snowflake_data_loaded.png)
