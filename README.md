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



