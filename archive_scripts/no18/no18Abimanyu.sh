htpasswd -b -c /etc/apache2/.htpasswd Wayang baratayudaE15

echo '<VirtualHost *:14000>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identi$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.E15
        ServerName rjp.baratayuda.abimanyu.E15.com
        ServerAlias www.rjp.baratayuda.abimanyu.E15.com

        <Directory /var/www/rjp.baratayuda.abimanyu.E15>
                AuthType Basic
                AuthName "SPYxFAMILY MOVIE ENTER"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>
        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, $

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

        <Directory /var/www/rjp.baratayuda.abimanyu.E15>
                AuthType Basic
                AuthName "SPYxFAMILY MOVIE ENTER"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, $

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        
        # For most configuration files from conf-available/, whic$        # enabled or disabled at a $        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14400.conf

service apache2 restart