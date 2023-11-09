# Ansible serveri skriptide paigaldusjuhend

## Skriptid

### apache_paigaldus.sh 

See skript paigaldab Apache veebiserveri ning seab selle käivituma automaatselt süsteemi käivitamisel, kui see pole juba nii tehtud.

### mysql_paigaldus.sh 

See skript paigaldab MySQL andmebaasiserveri ning seab selle käivituma automaatselt süsteemi käivitamisel, kui see pole juba nii tehtud.

### php_paigaldus.sh 

See skript paigaldab PHP, mida kasutatakse Apache veebiserveris. Samuti paigaldab see hulga valitud PHP mooduleid, mis on vajalikud mõne või mitme konkreetse rakenduse jaoks.

### phpmyadmin_paigaldus.sh

See skript paigaldab phpMyAdmin MySQL andmebaasi haldustarkvara, mis on mugav ja turvaline lahendus andmebaaside haldamiseks. Skript seab phpMyAdmin-i käivituma Apache veebiserveri all ning kasutab MySQL juurkasutaja parooli.

### wordpress_paigaldus.sh 

See skript paigaldab WordPressi sisuhaldussüsteemi ning seab selle käivituma Apache veebiserveriga. Skript loob uue MySQL andmebaasi, loob sellele uue kasutaja ja määrab talle õigused. WordPress saab paigaldada ainult pärast seda, kui MySQL ja PHP on juba paigaldatud.
