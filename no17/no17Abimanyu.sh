#!/bin/bash

cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14000.conf
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14400.conf

echo '<VirtualHost *:14000>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identi$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.E15
        ServerName rjp.baratayuda.abimanyu.E15.com
        ServerAlias www.rjp.baratayuda.abimanyu.E15.com

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, $        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a $        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14000.conf

echo '<VirtualHost *:14400>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identi$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.E15
        ServerName rjp.baratayuda.abimanyu.E15.com
        ServerAlias www.rjp.baratayuda.abimanyu.E15.com

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, $        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a $        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14400.conf

echo 'Listen 80
Listen 14000
Listen 14400
<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>' > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.E15.com-14000.conf
a2ensite rjp.baratayuda.abimanyu.E15.com-14400.conf

mkdir /var/www/rjp.baratayuda.abimanyu.E15

mv /jarkom-modul2-resources-main/rjp.baratayuda.abimanyu.E15 /var/www/
service apache2 restart