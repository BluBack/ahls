---
- hosts: webservers
  become: true
  become_user: root
  tasks:
  - name: Loome allalaadimiseks kataloogi
    file:
      path=/root/allalaadmised
      owner=root
      group=root
      mode=0755
      state=directory

  - name: Allalaadmine mysql_5.7 repositooriumi pakett apt-i lisamiseks
    get_url:
      url: https://repo.mysql.com/mysql-apt-config_0.8.26-1_all.deb
      dest: "/root/allalaadmised"
      mode: 0440

  - name: installeerime mysql_5.7 repositoorium
    apt: "deb=/root/allalaadmised/mysql-apt-config_0.8.26-1_all.deb"



