apt-get install apache2 -y
service apache2 start
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.E15.com.conf

echo '<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identify itself. This is used when c$        # redirection URLs. In the context of virtual hosts, the $        # specifies what hostname must appear in the requests Ho$        # match this virtual host. For the default virtual host ($        # value is not decisive as it is used as a last resort ho$        # However, you must set it for any further virtual host e$        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.E15
        ServerName abimanyu.E15.com
        ServerAlias www.abimanyu.E15.com

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for parti$        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a global level, it is possible to        # include a line for only one particular virtual host. Fo$        # following line enables the CGI configuration for this h$        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
        </VirtualHost>
    ' > /etc/apache2/sites-available/abimanyu.E15.com.conf

a2ensite abimanyu.E15.com
service apache2 restart

mkdir /var/www/abimanyu.E15
apt-get install wget unzip -y

wget https://github.com/weynard02/jarkom-modul2-resources/archive/refs/heads/main.zip
unzip main.zip
mv jarkom-modul2-resources-main/abimanyu.E15 /var/www/abimanyu.E15
