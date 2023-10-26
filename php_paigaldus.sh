#!/bin/bash

# Värskendame paketihaldurit ja paigaldame PHP ning vajalikud abipaketid
apt update
apt install -y php

# Paigaldame olulised PHP moodulid
apt install -y php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Konfigureerime PHP.ini faili vastavalt vajadusele
PHP_INI_PATH="/etc/php/$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')/apache2/php.ini"
sed -i 's/memory_limit = .*/memory_limit = 256M/' $PHP_INI_PATH
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 64M/' $PHP_INI_PATH
sed -i 's/post_max_size = .*/post_max_size = 64M/' $PHP_INI_PATH

# Taaskäivitame Apache, et muudatused jõustuksid
systemctl restart apache2

# Teavitame kasutajat, et paigaldamine on lõpetatud
echo "PHP on paigaldatud ja konfigureeritud veebiserveris."

# Väljastame PHP versiooni
php -v
