---
- hosts: webservers
  tasks:
    - name: install apache2
      apt: name=apache2 state=latest

    - name: Loome public_html kataloog userile
      file:
       path=/home/kristo/public_html
       owner=kristo
       group=kristo
       mode=0755
       state=directory

    - name: Lubame userdir mod
      apache2_module: name=userdir state=present

    - name: Apache2 serverile alglaadimine
      service:
        name: apache2
        state: restarted

    - name: Kopeerime index.html faili Userile kodus_public_html kataloogi
      copy:
        src: /var/www/html/index.html
        dest: /home/kristo/public_html/
        remote_src: yes
        owner: kristo
        group: kristo

