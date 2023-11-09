---
- hosts: webservers
  tasks:
    - name: installime php7.3
      apt: name=php7.3 state=latest
    - name: installime libapache2-mod-php7.3
      apt: name=libapache2-mod-php7.3 state=latest
    - name: installime php7.3-mysql
      apt: name=php7.3-mysql state=latest

    - name: alglaadimine aoache2
      service:
        name: apache2
        state: restarted


