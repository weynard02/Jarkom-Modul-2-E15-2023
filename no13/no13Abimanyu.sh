#!/bin/bash
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf

echo '<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identi$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/parikesit.abimanyu.E15
        ServerName parikesit.abimanyu.E15.com
        ServerAlias www.parikesit.abimanyu.E15.com

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a $        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf


a2ensite parikesit.abimanyu.E15.com.conf

mkdir /var/www/parikesit.abimanyu.E15

mv /jarkom-modul2-resources-main/parikesit.abimanyu.E15 /var/www/
service apache2 restart