@echo off
echo Changing authentication method...
echo host    all             all             127.0.0.1/32            trust > "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"
echo host    all             all             ::1/128                 trust >> "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"
echo local   all             all                                     trust >> "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"

echo Starting PostgreSQL service...
net start postgresql-x64-17

echo Setting new password...
"C:\Program Files\PostgreSQL\17\bin\psql" -U postgres -h localhost -c "ALTER USER postgres WITH PASSWORD 'postgres123';"

echo Restoring authentication method...
echo host    all             all             127.0.0.1/32            scram-sha-256 > "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"
echo host    all             all             ::1/128                 scram-sha-256 >> "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"
echo local   all             all                                     scram-sha-256 >> "C:\Program Files\PostgreSQL\17\data\pg_hba.conf"

echo Restarting PostgreSQL service...
net stop postgresql-x64-17
net start postgresql-x64-17 