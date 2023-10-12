echo '<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identify itself. This is$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.E15
        ServerName abimanyu.E15.com
        ServerAlias www.abimanyu.E15.com
        <Directory /var/www/abimanyu.E15/index.php/home>
                Options +Indexes
        </Directory>

        Alias "/home" "/var/www/abimanyu.E15/index.php/home"
        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for parti$        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a global level, it i$        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
    ' > /etc/apache2/sites-available/abimanyu.E15.com.conf

a2ensite abimanyu.E15.com.conf
service apache2 restart
