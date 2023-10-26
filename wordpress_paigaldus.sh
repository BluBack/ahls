#!/bin/bash

# Skripti nimi: wordpress_paigaldus.sh
# Kirjeldus: See skript kontrollib, kas vajalikud teenused on paigaldatud, ja paigaldab WordPressi ning teostab vajalikud seadistused.
# Autor: Sinu Nimi
# Kuupäev: 26. oktoober 2023

# Kontrollime, kas skripti käivitaja on root kasutaja
if [ "$EUID" -ne 0 ]; then
    echo "Palun käivita skript root kasutajana"
    exit
fi

# Kontrollime, kas apache_paigaldus.sh, php_paigaldus.sh ja pma_paigaldus.sh on olemas ja käivitatavad
if [ ! -x "./apache_paigaldus.sh" ] || [ ! -x "./php_paigaldus.sh" ] || [ ! -x "./pma_paigaldus.sh" ]; then
    echo "Vajalikud skriptid (apache_paigaldus.sh, php_paigaldus.sh, pma_paigaldus.sh) puuduvad või pole käivitatavad. Palun veendu, et need skriptid on olemas ja käivitatavad."
    exit
fi

# Kontrollime, kas vajalikud teenused on paigaldatud
dpkg -l apache2 php phpmyadmin > /dev/null 2>&1
apache_installed=$?
php_installed=$?
pma_installed=$?

if [ $apache_installed -ne 0 ] || [ $php_installed -ne 0 ] || [ $pma_installed -ne 0 ]; then
    echo "Apache, PHP või phpMyAdmin teenus ei ole korralikult paigaldatud. Palun paigalda need teenused enne WordPressi paigaldamist."
    exit
fi

# Paigaldame WordPressi
echo "Paigaldame WordPressi..."
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz -C /var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Genereerime juhusliku salasõna WordPressi konfiguratsioonifaili jaoks
salasona=$(openssl rand -base64 12)
sed -i "s/define('DB_PASSWORD', '');/define('DB_PASSWORD', '$salasona');/" /var/www/html/wordpress/wp-config.php

echo "WordPress on edukalt paigaldatud ja seadistatud!"
echo "Järgmine samm on WordPressi konfigureerimine veebibrauseris."

# Skripti lõpp
