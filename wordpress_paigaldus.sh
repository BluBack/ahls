---
- hosts: webservers
  become: yes
  become_user: root
  tasks:

  - name: Loome andmebaas wordpressi jaoks wpdatabase
    mysql_db:
      name: wpdatabase
      state: present

  - name: loome kasutaja wpuser ja maarame parool qwerty koos koikide privi
    mysql_user:
      name: root
      password: qwerty
      priv: 'wpdatabase.*:ALL,GRANT'
      state: present
      check_implicit_admin: yes

  - name: alglaadmine mysql
    service: name=mysql state=restarted

  - name: laen alla ja pakin lahti wordi
    unarchive:
      src: https://wordpress.org/latest.tar.gz
      dest: /var/www/html/
      remote_src: yes

  - name: Vahetame wordpress kausta omanikku
    file:
      path: /var/www/html/wordpress/
      state: directory
      recurse: yes
      owner: www-data

  - name: kopeerime config faili
    command: cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

  - name: Vahetame DB_PASSWORD
    lineinfile: dest=/var/www/html/wordpress/wp-config.php regexp="password_here" line="define( 'DB_PASSWORD', 'qwer$
  - name: Vahetame DB_USER
    lineinfile: dest=/var/www/html/wordpress/wp-config.php regexp="username_here" line="define( 'DB_USER', 'root' );"
  - name: Vahetame DB_NAME
    lineinfile: dest=/var/www/html/wordpress/wp-config.php regexp="database_name_here" line="define( 'DB_NAME', 'wpd$
