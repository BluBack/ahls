#!/bin/bash
# Kontrollime, kas skripti käivitaja on root kasutaja
if [ "$EUID" -ne 0 ]
  then echo "Palun käivita skript root kasutajana"
  exit
fi

# Paigaldame vajalikud paketid (Apache, PHP ja phpMyAdmin)
echo "Paigaldame vajalikud paketid..."
apt-get update
apt-get -y install apache2 php php-mysql phpmyadmin

# Konfigureerime phpMyAdmini teenuse
echo "Konfigureerime phpMyAdmini..."
ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
a2enconf phpmyadmin
service apache2 restart

# Kontrollime, kas paigaldamine õnnestus
if [ $? -eq 0 ]; then
    echo "phpMyAdmin on edukalt paigaldatud ja konfigureeritud!"
else
    echo "phpMyAdmini paigaldamisel ilmnes viga. Palun kontrolli süsteemi logisid."
fi

# Skripti lõpp
