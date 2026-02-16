# Dockerized dbt StarRocks Scaffold

This project provides a pre-configured environment for running dbt models against StarRocks, with a federated JDBC connection to SQL Server.

## Quick Start

### 1. Start Infrastructure
Start StarRocks (v4.0.0) and SQL Server:
```bash
docker compose up -d
```

### 2. Initialize Databases
Seed SQL Server with test data and configure the StarRocks JDBC catalog:
```bash
# Initialize SQL Server (Create table & indexes)
docker exec mssql-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'YourPassword123!' -i /scripts/init-sqlserver.sql -C

# Initialize StarRocks (Create catalog & database)
docker exec starrocks-dev mysql -h 127.0.0.1 -P 9030 -uroot -e "source /docker-entrypoint-initdb.d/init-starrocks.sql"
```

### 3. Run dbt
Execute the optimized incremental model which ensures index usage on SQL Server:
```bash
# Direct dbt run
docker compose run --rm dbt dbt run --select my_optimized_incremental_model
```

## Available Models
- `my_incremental_model`: Uses a standard subquery for the watermark (Results in Full Table Scan on SQL Server).
- `my_optimized_incremental_model`: Uses Jinja literal injection to ensure **Predicate Pushdown** (Results in Index Seek on SQL Server).

## Verification
Verify the data in StarRocks:
```bash
docker exec starrocks-dev mysql -h 127.0.0.1 -P 9030 -uroot -e "USE main; SELECT * FROM my_optimized_incremental_model;"
```

Check the query plan to verify index bypass/usage:
```bash
docker exec starrocks-dev mysql -h 127.0.0.1 -P 9030 -uroot -e "USE main; EXPLAIN SELECT * FROM jdbc_sqlserver.dbo.table_in_sqlserver WHERE report_time > '2025-11-01';"
```

## Performance Note
For detailed information on why we use Jinja variables for incremental watermarks, see the [Pushdown Walkthrough](file:///Users/oluwafemi.sule/.gemini/antigravity/brain/52327b6c-cd51-40e4-a8f0-d5d1dbbc6c70/pushdown_walkthrough.md).
