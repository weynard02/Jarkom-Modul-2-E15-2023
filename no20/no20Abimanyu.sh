# Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

echo 'RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.E15.com/public/images/abimanyu.png$1 [L,R=301]' > /var/www/parikesit.abimanyu.E15/.htaccess

echo -e '<VirtualHost *:80>
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

  <Directory /var/www/parikesit.abimanyu.E15>
          Options +FollowSymLinks -Multiviews
          AllowOverride All
  </Directory>

  Alias "/public" "/var/www/parikesit.abimanyu.E15/public"
  Alias "/secret" "/var/www/parikesit.abimanyu.E15/secret"
  Alias "/js" "/var/www/parikesit.abimanyu.E15/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf

a2enmod rewrite

service apache2 restart
