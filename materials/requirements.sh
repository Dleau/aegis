sudo apt-get install postgresql postgresql-client libpq-dev build-essential libpq5 ruby-all-dev &&
echo 'Opening pg_hba.conf for editing (change first occurance of peer to trust)...' && sleep 1 &&
sudo vim /etc/postgresql/10/main/pg_hba.conf &&
echo 'Rebooting postgresql service...' && sleep 1 &&
sudo service postgresql restart &&
echo 'Dependency installation complete!'
