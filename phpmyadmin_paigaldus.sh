---
- hosts: webservers
  tasks:
    - name: debconf for pma
      debconf: name=phpmyadmin question='phpmyadmin/dbconfig-install' value='true' vtype='boolean'

    - name: debconf for pma
      debconf: name=phpmyadmin question='phpmyadmin/app-password-confirm' value='qwerty' vtype='password'

    - name: debconf for pma
      debconf: name=phpmyadmin question='phpmyadmin/mysql/admin-pass' value='qwerty' vtype='password'

    - name: debconf for pma
      debconf: name=phpmyadmin question='phpmyadmin/mysql/app-pass' value='qwerty' vtype='password'

    - name: debconf for pma
      debconf: name=phpmyadmin question='phpmyadmin/reconfigure-webserver' value='' vtype='multiselect'

    - name: Paigaldan phpmyadmin-5.2.1
      unarchive:
        src: https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
        dest: /var/www/html/
        remote_src: yes

    - name: Muudan kausta nime 'phpmyadmin'
      command: mv /var/www/html/phpMyAdmin-5.2.1-all-languages/ /var/www/html/kristo/

    - name: Kopeerin konfiguratsioonifaili
      command: cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/kristo/config.inc.php

    - name: Lisan konfiguratsioonifaili kõigile lugemisõiguse
      command: chmod 664 /var/www/html/kristo/config.inc.php

    - name: Teen apache2 taaskäivituse
      command: systemctl restart apache2

    - name: Paigaldan php-mbstring
      apt: name=php-mbstring update_cache=yes state=latest

    - name: Määran kausta 'phpmyadmin' omaniku ja grupi 'www-data'
      file:
        path: /var/www/html/kristo/
        state: directory
        recurse: yes
        owner: www-data
        group: www-data

