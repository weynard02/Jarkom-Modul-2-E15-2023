mkdir /var/www/parikesit.abimanyu.E15/secret/
touch /var/www/parikesit.abimanyu.E15/secret/home.html

echo '<!DOCTYPE html>
<html>
<body>

<h1>Kamu kok bisa buka?</h1>
<p>Coba cek lagi!</p>

</body>
</html>' > /var/www/parikesit.abimanyu.E15/secret/home.html


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
        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, al$        # It is also possible to configure the loglevel for parti$        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disa$        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf

a2ensite parikesit.abimanyu.E15.com.conf
service apache2 restart