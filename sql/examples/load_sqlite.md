Quick start (SQLite)

1. Create database and load schema
   sqlite3 demo.db < sql/schema.sqlite.sql

2. Import CSVs
   .mode csv
   .import datasets/users.csv users
   .import datasets/orders.csv orders

3. Run solutions to compare
   .read sql/solutions/001_basic_joins.sql

