@echo off
echo Installing dependencies...
call npm install

echo Setting up database...
set PGPASSWORD=postgres123
"C:\Program Files\PostgreSQL\17\bin\psql" -U postgres -h localhost -f setup.sql
set PGPASSWORD=

echo Starting the server...
npm run dev 