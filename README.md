# Jarkom-Modul-2-E15-2023

<table>
    <tr>
        <th colspan=2> Kelompok E15 </th>
    </tr>
    <tr>
        <th>NRP</th>
        <th>Nama Anggota</th>
    </tr>
    <tr>
        <td>5025211014</td>
        <td>Alexander Weynard Samsico</td>
    </tr>
  <tr>
        <td>5025211121</td>
        <td>Frederick Yonatan Susanto</td>
    </tr>
</table>

## 1. Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian [sebagai berikut](https://docs.google.com/spreadsheets/d/1OqwQblR_mXurPI4gEGqUe7v0LSr1yJViGVEzpMEm2e8/edit#gid=1475903193). Folder topologi dapat diakses pada [ drive berikut](https://drive.google.com/drive/folders/1Ij9J1HdIW4yyPEoDqU1kAwTn_iIxg3gk) 



## 11. Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

Pertama, kita perlu menginstall apache2 pada Abimanyu terlebih dahulu.
```
apt-get install apache2 -y
service apache2 start
```

Kemudian kita membuat konfigurasi sites menggunakan template `000-default.conf`
```
mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.E15.com.conf
```

dan menyesuaikan dengan format nama server dan alias yang diberikan serta DocumentRootnya
```
<VirtualHost *:80>
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
```

Kemudian mengaktifkan konfigurasi abimanyu.E15.com.conf tersebut
```
a2ensite abimanyu.E15.com.conf
```

install package berikut agar tampilan terlihat
```
apt-get install libapache2-mod-php7.0
```

Setelah itu, membuat DocumentRootnya dan mendownload resource yang diberikan dengan menggunakan `wget` dan `unzip` pada folder tersebut
```
mv jarkom-modul2-resources-main/abimanyu.E15 /var/www/
```

Terakhir tinggal direstart
```
service apache2 restart
```

Kita dapat melakukan testing pada Client dengan menggunakan
```
lynx www.abimanyu.E15.com
```

### Hasil: 
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/58492990-96a8-4a12-afa4-e4643d5da016)


## 12. Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.
Awalnya jika membuka www.abimanyu.E15.com/home tidak bisa dilakukan. Oleh karena itu, kita perlu membuat alias '/home' dengan menambahkan statements ini di konfigurasinya
```
<Directory /var/www/abimanyu.E15/index.php/home>
                Options +Indexes
        </Directory>

Alias "/home" "/var/www/abimanyu.E15/index.php/home"
```

```
<VirtualHost *:80>
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
```
Kemudian direstart dan melakukan testing pada `www.abimanyu.E15.com/home`

### Hasil:
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/06160e84-4c4d-4bc7-9de3-23a35075213b)


## 13. Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy
Untuk soal ini, kita bisa meniru seperti nomor sebelumnya dan tambahan tertentu. Pertama kita dapat mengcopy template dari abimanyu.E15.com 
```
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf
```

Kemudian membuat konfigurasinya dengan nama dan alias
```
<VirtualHost *:80>
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
```
Kemudian diaktifkan 
```
a2ensite parikesit.abimanyu.E15.com.conf
```
Setelah itu, membuat folder DocumentRoot dan mendapatkan resource yang didownload sebelumnya
```
mkdir /var/www/parikesit.abimanyu.E15

mv /jarkom-modul2-resources-main/parikesit.abimanyu.E15 /var/www/
```

Akan tetapi, dengan seperti ini belum selesai, karena www.parikesit.abimanyu.E15.com belum terdaftar pada DNS-MASTERnya, sehingga perlu dikonfigurasi ulang DNSnya di Yudhistira menjadi sebagai berikut
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.E15.com. root.abimanyu.E15.com. (
                        2023100901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.E15.com.
@       IN      A       10.44.3.2
www     IN      CNAME   abimanyu.E15.com.
parikesit IN      A              10.44.3.2
www.parikesit   IN      CNAME   parikesit
ns1             IN      A       10.44.3.2       ; IP Abimanyu
baratayuda      IN      NS      ns1
@       IN      AAAA    ::1
```

Kemudian di Abimanyu dan merestart apache2 dan melakukan testing di Client
```
service apache2 restart
```
Di Client:
```
lynx www.parikesit.abimanyu.E15.com 
```

### Hasil:
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/665f4ebc-55ca-4b45-b3a1-5a07a8d8c73a)

## 14. Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).
Untuk soal ini, kita dapat mengatur directory listing dengan menambahkan konfigurasi sebagai berikut:

Untuk menyalakan /public
```
<Directory /var/www/parikesit.abimanyu.E15/public>
    Options +Indexes
</Directory>
```

Untuk mematikan /secret
```
<Directory /var/www/parikesit.abimanyu.E15/secret>
    Options -Indexes
</Directory>
```

```
<VirtualHost *:80>
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
```

kita bisa membuat directory /secret dan menambahkan `home.html` sebagai pengujian 
```
mkdir /var/www/parikesit.abimanyu.E15/secret/
touch /var/www/parikesit.abimanyu.E15/secret/home.html

echo '<!DOCTYPE html>
<html>
<body>

<h1>Kamu kok bisa buka?</h1>
<p>Coba cek lagi!</p>

</body>
</html>' > /var/www/parikesit.abimanyu.E15/secret/home.html
```

Kemudian apache2 direstart dan dapat melakukan testing untuk www.parikesit.abimanyu.E15.com/public dan www.parikesit.abimanyu.E15.com/secret

### Hasil:
/public

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/b803054e-d8fe-455c-9b72-bcf2a9a2736c)

/secret

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/ba086570-3d4f-425c-931f-2f51de97b5d9)

## 15. Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.
Untuk dapat menggunakan custom error page yang dibuat dari /error kita dapat menambahkan perintah-perintah tersebut pada konfigurasi
```
ErrorDocument 404 /error/404.html
ErrorDocument 403 /error/403.html
```

Penjelasan:
- Menyatakan jika untuk ErrorDocument 404, maka diexecute halaman /error/404.html
- jika untuk ErrorDocument 403, maka diexecute halaman /error/403.html

```
<VirtualHost *:80>
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
        # For most configuration files from conf-available/, whic$        # enabled or disa$        
</VirtualHost>
```

Kemudian direstart dan dapat melakukan testing 403 dan 404

### Hasil:
403:

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/a467897b-5a58-4106-bd47-bdc84905fb31)


404:

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/3b0ae947-fbce-429b-9e72-2d9434af6641)


## 16. Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi 
www.parikesit.abimanyu.yyy.com/js 
Untuk soal ini, kita perlu membuat alias '/js' di konfigurasi dengan menambahkan perintah ini:
```
<Directory /var/www/parikesit.abimanyu.E15/public/js>
                Options +Indexes
        </Directory>

Alias "/js" "/var/www/parikesit.abimanyu.E15/public/js"
```

```
<VirtualHost *:80>
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
        <Directory /var/www/parikesit.abimanyu.E15/public/js>
                Options +Indexes
        </Directory>

        Alias "/js" "/var/www/parikesit.abimanyu.E15/public/js"
        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, al$

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        ErrorDocument 404 /error/404.html
        ErrorDocument 403 /error/403.html
        # For most configuration files from conf-available/, whic$        # enabled or disa$
</VirtualHost>
```

Kemudian direstart dan dapat testing www.parikesit.abimanyu.yyy.com/js 

### Hasil:
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/c29d80a1-d15d-4083-89a3-3ba87347f15e)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/3b491f43-36d0-4231-a08d-7237ecb2fed0)



## 17. Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.
Untuk soal ini, kita perlu membuat 2 konfigurasi untuk www.rjp.baratayuda.abimanyu.E15.com untuk port 14000 dan www.rjp.baratayuda.abimanyu.E15.com untuk port 14400.

Langkah pertama kita mencopy template dari konfigurasi sebelumnya dan mengedit konfigurasi sebagai berikut:
```
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14000.conf
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14400.conf

```
Di rjp.baratayuda.abimanyu.E15.com-14000.conf:
```
'<VirtualHost *:14000>
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
```
Penjelasan: mengganti port 14000 dan mengganti ServerName, Alias, dan Document Root

Di rjp.baratayuda.abimanyu.E15.com-14400.conf:
```
<VirtualHost *:14400>
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
```
Penjelasan: mengganti port 14400 dan mengganti ServerName, Alias, dan Document Root


Setelah itu, kita perlu mendaftar port-port tersebut di dalam /etc/apache2/ports.conf
```
Listen 80
Listen 14000
Listen 14400
<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
```

Kemudian mengaktifkan dua konfigurasi tersebut:
```
a2ensite rjp.baratayuda.abimanyu.E15.com-14000.conf
a2ensite rjp.baratayuda.abimanyu.E15.com-14400.conf
```

dan memindahkan resources yang sebelum didownload ke DocumentRoot
```
mkdir /var/www/rjp.baratayuda.abimanyu.E15

mv /jarkom-modul2-resources-main/rjp.baratayuda.abimanyu.E15 /var/www/
```

Terakhir, melakukan restart dan lakukan testing
```
service apache2 restart
```

### Hasil:

lynx www.rjp.baratayuda.abimanyu.E15.com:14000

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/09b8f95a-c0a5-4cf2-852b-88a2150b88bc)

lynx www.rjp.baratayuda.abimanyu.E15.com:14400

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/e5421eaa-6a12-4966-9d1b-3252031a040b)

lynx www.rjp.baratayuda.abimanyu.E15.com:14200

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/f924269f-d9ca-4975-8d94-2fad9c9625d1)


## 18. Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.

Untuk membuat autentikasi, pertama kita perlu membuat file .htpasswd dengan command line sebagai berikut
```
htpasswd -b -c /etc/apache2/.htpasswd Wayang baratayudaE15
```

Penjelasan:
- htpasswd membuat file pada /etc/apache2/.htpasswd yang berisi username Wayang dan password baratayudaE15

Kemudian setelah itu ditambahkan pada konfigurasi setiap port masing-masing dengan perintah berikut:
```
<Directory /var/www/rjp.baratayuda.abimanyu.E15>
                AuthType Basic
                AuthName "SPYxFAMILY MOVIE ENTER"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
</Directory>
```

/etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14000.conf
```
<VirtualHost *:14000>
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
```

/etc/apache2/sites-available/rjp.baratayuda.abimanyu.E15.com-14400.conf
```
<VirtualHost *:14400>
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
```

Kemudian direstart dan melakukan testing misalkan pada www.rjp.baratayuda.abimanyu.E15.com:14000

### Hasil:
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/3a505a02-d35a-4a56-8934-9b085e5ccfc2)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/ecf96cd5-cd29-475d-bb82-08bafa86a63d)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/5db839a1-b2ca-4c37-b6e4-c47dbdb6d069)

Jika autentikasi benar, maka harusnya keluar tampilannya
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/8e3e3e38-bca1-423b-85c5-51d717e27787)


## 19. Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)
Untuk soal ini, kita membuat default-abimanyu.E15.com saja yang merepresentasikan ServerNamenya merupakan IP Abimanyu. Kemudian, kita dapat menambahkan perintah pada konfigurasi sebagai berikut:
```
RedirectPermanent / http://www.abimanyu.E15.com
```
Penjelasan: artinya bahwa setiap kali mengakses IP Abimanyu maka akan langsung dilemparkan pada http://www.abimanyu.E15.com

Pembuatan konfigurasi sebagai berikut
```
cp /etc/apache2/sites-available/abimanyu.E15.com.conf /etc/apache2/sites-available/default-abimanyu.E15.com.conf
```

/etc/apache2/sites-available/default-abimanyu.E15.com.conf
```
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostn$        # the server uses to identi$

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.E15
        ServerName 10.44.3.2
        RedirectPermanent / http://www.abimanyu.E15.com

        # Available loglevels: trace8, ..., trace1, debug, info, $        # error, crit, alert, emerg.        # It is also possible to configure the loglevel for parti$        # modules, $        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, whic$        # enabled or disabled at a $        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
```
Penjelasan 
Kemudian dinyalakan sitenya dan direstart serta ditesting
```
a2ensite default-abimanyu.E15.com.conf
service apache2 restart
```

### Hasil:
lynx 10.44.3.2 // IP Abimanyu

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/2830db57-d5b5-4a21-996a-5976c84b5147)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/503ba2aa-f709-45d4-be2f-16c4c08c0648)


## 20. Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

Untuk soal ini, jika kita lihat dari resource ada banyak macam-macam gambar:
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/caac6b4d-41c8-448c-b75d-cb74d1d158a2)

Soal meminta apabila kita mencoba access/request gambar yang mengandung substring abimanyu akan diarahkan menuju abimanyu.png (rewrite) 

Agar dapat melakukan rewrite itu, kita perlu membuat .htaccess pada DocumentRoot `/var/www/parikesit.abimanyu.E15/.htaccess` yang berisi berikut:
```
RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg|jpeg|webp|bmp|tiff|svg))
RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
RewriteRule abimanyu http://parikesit.abimanyu.E15.com/public/images/abimanyu.png$1 [L,R=301]
```
Penjelasan:
- Rewrite dinyalakan
- Kondisi jika menemukan request uri /public/images/(mengandung substring abimanyu).(berextension tipe file gambar)
- dan kondisi jika /public/images/abimanyu.png
- maka akan melakukan rewrite rule di mana rewrite menjadi http://parikesit.abimanyu.E15.com/public/images/abimanyu.png

Kemudian menambahkan pada konfigurasi /etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf dengan perintah ini:
```
<Directory /var/www/parikesit.abimanyu.E15>
    Options +FollowSymLinks -Multiviews
    AllowOverride All
</Directory>
```
Penjelasan:
- `+FollowSymLinks`: mod_rewrite berjalan
- `-Multiviews`: mod_negotiation tidak berjalan karena bisa mengganggu mod_rewrite karena juga berperan sebagai rewrite
- `AllowOverride All`: .htaccess berjalan

/etc/apache2/sites-available/parikesit.abimanyu.E15.com.conf
```
<VirtualHost *:80>

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

  <Directory /var/www/parikesit.abimanyu.E15/public/js>
        Options +Indexes
  </Directory>

  Alias "/js" "/var/www/parikesit.abimanyu.E15/public/js"

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Kemudian kita perlu menyalakan mod rewrite dan direstart apache2nya
```
a2enmod rewrite

service apache2 restart
```

### Hasil:
lynx parikesit.abimanyu.E15.com/public/images/abimanyu-student.jpg

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/035ad515-e932-497e-b10c-caef68098adb)

lynx parikesit.abimanyu.E15.com/public/images/not-abimanyu.png

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/76fc8f58-6229-4797-b37f-2f12f8de9c61)


## Kendala:
- Pada nomor 11, sempat kesulitan mengapa saat apache2 direstart, membuat error bahwa port 80 sudah dipakai padahal baru pertama kali jalan. Ternyata masalahnya adalah page default nginx (yang menggunakan port80) belum diremove
- Pada nomor 13, sempat kesulitan mengapa alias tidak berjalan (www.parikesit.abimanyu.E15.com). Ternyata karena soal sebelumnya tidak diminta membuat aliasnya sehingga belum dibuat pada DNS-Masternya
- Terdapat beberapa konfigurasi di luar modul, sehingga perlu mencari tau melalui google (ErrorDocument, htpasswd, RedirectPermanent, dll)
