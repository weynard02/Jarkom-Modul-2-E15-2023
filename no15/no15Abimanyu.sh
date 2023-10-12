echo '<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostn$        # the server uses$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/parikesit.abimanyu.E15
        ServerName parikesit.abimanyu.E15.com
        ServerAlias www.parikesit.abimanyu.E15.com

         <Directory /var/www/parikesit.abimanyu.E15/public>
                Options +Indexes
        </Directory>
        <Directory /var/www/parikesit.abimanyu.E15/secret>
                Options -Indexes
        </Directory>
        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, al$        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        ErrorDocument 404 /error/404.html
        ErrorDocument 403 /error/403.html
        # For most configuration files from conf-available/, whic$        # enabled or disa$        </VirtualHost>
    </VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf
service apache2 restart