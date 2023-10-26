#!/bin/bash

# MySQL serveri paigaldusskript

# Kontrollime, kas skripti käivitaja on root kasutaja
if [ "$(id -u)" != "0" ]; then
    echo "Skripti käivitamiseks peate olema root kasutaja."
    exit 1
fi

# Värskendame paketihaldurit
apt update

# Paigaldame MySQL-serveri teenuse
apt install -y mysql-server

# Käivitame MySQL serveri teenuse
service mysql start

# MySQL teenuse oleku kontroll
if service mysql status | grep -q "active (running)"; then
    echo "MySQL-server on edukalt paigaldatud ja käivitatud."
else
    echo "MySQL-serveri paigaldamisel tekkis viga. Palun kontrollige süsteemi logifaile."
fi

# Annab juurdepääsu MySQL serverile ilma paroolita (NB! See on turvarisk ja peaks olema vaid testimiseks)
echo "Luban juurdepääsu MySQL serverile ilma paroolita (ainult testimiseks!)"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Näitame MySQL serveri versiooni
mysql_version=$(mysql --version)
echo "MySQL serveri versioon: $mysql_version"
