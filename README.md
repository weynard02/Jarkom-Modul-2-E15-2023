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

## Topologi 

![04](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/091df6af-e677-4d8f-af41-6b23d5f64f34)

## Config

### Pandudewanata 
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.44.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.44.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.44.3.1
	netmask 255.255.255.0
```
### Werkudara
```
auto eth0
iface eth0 inet static
	address 10.44.1.2
	netmask 255.255.255.0
	gateway 10.44.1.1
```

### Yudhistira
```
auto eth0
iface eth0 inet static
	address 10.44.1.3
	netmask 255.255.255.0
	gateway 10.44.1.1
```

### Nakula
```
auto eth0
iface eth0 inet static
	address 10.44.2.2
	netmask 255.255.255.0
	gateway 10.44.2.1
```

### Sadewa
```
auto eth0
iface eth0 inet static
	address 10.44.2.3
	netmask 255.255.255.0
	gateway 10.44.2.1
```

### Abimanyu
```
auto eth0
iface eth0 inet static
	address 10.44.3.2
	netmask 255.255.255.0
	gateway 10.44.3.1
```

### Prabukusuma
```
auto eth0
iface eth0 inet static
	address 10.44.3.3
	netmask 255.255.255.0
	gateway 10.44.3.1
```

### Wisanggeni
```
auto eth0
iface eth0 inet static
	address 10.44.3.4
	netmask 255.255.255.0
	gateway 10.44.3.1
```

### Arjuna
```
auto eth0
iface eth0 inet static
	address 10.44.3.5
	netmask 255.255.255.0
	gateway 10.44.3.1
```
## Setup
Pada .bashrc menggunakan nano :

### Pandudewanata
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.44.0.0/16
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
```

### DNSMaster dan DNSSlave
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y
```

### Client
```
echo -e '
nameserver 10.44.1.3 # IP Yudhistira
nameserver 10.44.1.2 # IP Werkudara
nameserver 192.168.122.1
' > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
```

# Soal

## 1. Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian [sebagai berikut](https://docs.google.com/spreadsheets/d/1OqwQblR_mXurPI4gEGqUe7v0LSr1yJViGVEzpMEm2e8/edit#gid=1475903193). Folder topologi dapat diakses pada [ drive berikut](https://drive.google.com/drive/folders/1Ij9J1HdIW4yyPEoDqU1kAwTn_iIxg3gk) 

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/f8746129-3008-45f1-8ea6-2b22813d65d0)

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Disini kita perlu melakukan testing terhadap semua node yang ada. Disini kami melakukan testing pada client nakula dan sadewa.

#### Semua Node
```
ping google.com -c 5
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/aa4e3cee-3722-4f7d-a4b1-1e28ca6b05e4)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/31b7870c-ee63-4a0b-8bc6-a5d061c275f8)

## 2. Buatlah website utama pada node arjuna dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok.

Pada node DNS Master (Yudhistira), kita perlu melakukan setup terlebih dahulu sebagai berikut:

#### Yudhistira
```
apt-get update
apt-get install bind9 -y

echo '
zone "arjuna.E15.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.E15.com";
};

' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.E15.com




echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.E15.com. root.arjuna.E15.com. (
                        2023100901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.E15.com.
@       IN      A       10.44.3.5
www     IN      CNAME   arjuna.E15.com.
@       IN      AAAA    ::1

' > /etc/bind/jarkom/arjuna.E15.com

service bind9 restart
```

#### Penjelasan :
1. `apt-get update` dan `apt-get install bind9 -y`: Mengupdate daftar paket dan menginstal BIND9.

2. `echo '...' > /etc/bind/named.conf.local`: Menambahkan konfigurasi untuk zona "arjuna.E15.com" ke dalam file `/etc/bind/named.conf.local`. Ini mendefinisikan zona sebagai zona master dan menunjuk ke file zona.

3. `mkdir /etc/bind/jarkom` dan `cp /etc/bind/db.local /etc/bind/jarkom/arjuna.E15.com`: Membuat direktori `/etc/bind/jarkom` dan menyalin file zona default (`db.local`) ke dalamnya dengan nama `arjuna.E15.com`.

4. `echo '...' > /etc/bind/jarkom/arjuna.E15.com`: Menambahkan catatan zona ke dalam file `/etc/bind/jarkom/arjuna.E15.com`. Ini mencakup catatan SOA (Start of Authority), NS (Name Server), A (Alamat IPv4), CNAME (Alias Kanonikal), dan AAAA (Alamat IPv6).

5. `service bind9 restart`: Merestart layanan BIND9 untuk menerapkan konfigurasi yang baru saja diubah.

#### Nakula / Client yang lain
Setup nameserver terlebih dahulu yang diarahkan ke IP Node yudhistira.

```
ping arjuna.E15.com -c 5
ping www.arjuna.E15.com -c 5
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/6e42ff51-d42d-43c5-baaa-d5a6dcef5d12)

## 3. Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

Pada node DNS Master (Yudhistira), kita perlu melakukan setup terlebih dahulu sebagai berikut:

#### Yudhistira
```
apt-get update
apt-get install bind9 -y

echo '
zone "arjuna.E15.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.E15.com";
};

zone "abimanyu.E15.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.E15.com";
};

' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.E15.com
cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.E15.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.E15.com. root.arjuna.E15.com. (
                        2023100901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.E15.com.
@       IN      A       10.44.3.5
www     IN      CNAME   arjuna.E15.com.
@       IN      AAAA    ::1

' > /etc/bind/jarkom/arjuna.E15.com

echo '
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
@       IN      AAAA    ::1

' > /etc/bind/jarkom/abimanyu.E15.com

service bind9 restart
```

#### Nakula / Client yang lain
Setup nameserver terlebih dahulu yang diarahkan ke IP Node yudhistira.

```
ping abimanyu.E15.com -c 5
ping www.abimanyu.E15.com -c 5
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/a18706b7-0eed-44ca-94f3-da7a729d569a)

## 4. Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Untuk subdomain, kita perlu menambahkan ```parikesit``` dengan type A yang mengarah langsung ke IP Abimanyu.

#### Yudhistira
Cukup menambahkan ```parikesit IN    A       10.44.3.2     ; IP Abimanyu' > /etc/bind/jarkom/abimanyu.E15.com saja pada DNS Master.

```
echo '
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
@         IN      NS      abimanyu.E15.com.
@         IN      A       10.44.3.2
www       IN      CNAME   abimanyu.E15.com.
parikesit IN      A              10.44.3.2
@           IN      AAAA    ::1

' > /etc/bind/jarkom/abimanyu.E15.com

service bind9 restart
```

#### Penjelasan :
1. `$TTL 604800`: Menentukan nilai Time-to-Live (TTL) untuk catatan zona, dalam detik.

2. `@ IN SOA abimanyu.E15.com. root.abimanyu.E15.com. ( ... )`: Mendefinisikan catatan SOA (Start of Authority) dengan informasi seperti nama domain, alamat email administrator (root.abimanyu.E15.com), dan parameter-parameter lainnya seperti Serial, Refresh, Retry, Expire, dan Negative Cache TTL.

3. `@ IN NS abimanyu.E15.com.`: Menetapkan Name Server untuk zona ini.

4. `@ IN A 10.44.3.2`: Mengaitkan alamat IPv4 10.44.3.2 dengan nama domain "abimanyu.E15.com".

5. `www IN CNAME abimanyu.E15.com.`: Membuat alias "www" yang menunjuk ke domain "abimanyu.E15.com".

6. `parikesit IN A 10.44.3.2`: Menetapkan alamat IPv4 10.44.3.2 untuk host "parikesit".

7. `@ IN AAAA ::1`: Mengaitkan alamat IPv6 (::1) dengan domain "abimanyu.E15.com".

8. `service bind9 restart`: Merestart layanan BIND9 untuk menerapkan konfigurasi baru.

#### Nakula / Client yang lain
```
ping parikesit.abimanyu.E15.com -c 5
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/2664a95e-f877-4b61-8158-eb599db82347)

## 5. Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Yang akan kita reverse domainnya adalah Abimanyu.
Untuk melakukan reverse domain. Kita perlu untuk mengetahui IP dari Abimanyu. Karena IP Abimanyu kelompok kami adalah 10.44.3.2, maka kita perlu mengubahnya menjadi 2.3.44.10.

#### Yudhistira
```
zone "3.44.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.44.10.in-addr.arpa";
};

cp /etc/bind/db.local /etc/bind/jarkom/3.44.10.in-addr.arpa

echo '
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
3.44.10.in-addr.arpa.   IN      NS      abimanyu.E15.com.
2                       IN      PTR     abimanyu.E15.com.

'  > /etc/bind/jarkom/3.44.10.in-addr.arpa

service bind9 restart
```
Sebelum mengakses, jangan lupa untuk mengembalikan nameserver ke DNS Master.

#### Penjelasan :
1. `zone "3.44.10.in-addr.arpa" { ... }`: Membuat zona untuk reverse DNS dengan alamat IP di subnet 10.44.3.0/24.

2. `cp /etc/bind/db.local /etc/bind/jarkom/3.44.10.in-addr.arpa`: Menyalin file zona default (`db.local`) ke dalam direktori `/etc/bind/jarkom` dengan nama `3.44.10.in-addr.arpa`.

3. `$TTL 604800` hingga `604800 )`: Konfigurasi TTL dan catatan SOA untuk reverse DNS, mirip dengan konfigurasi zona forward DNS.

4. `3.44.10.in-addr.arpa. IN NS abimanyu.E15.com.`: Menetapkan Name Server untuk zona reverse DNS.

5. `2 IN PTR abimanyu.E15.com.`: Mengaitkan alamat IP 10.44.3.2 dengan nama domain "abimanyu.E15.com".

#### Nakula / Client yang lain 
```
host -t PTR 10.44.3.2
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/c8417347-7a6b-4e02-92d3-9b96f84319ac)

## 6. Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Untuk mengerjakan DNS Slave, kita memerlukan beberapa konfigurasi pada DNS Master (Yudhistira) dan DNS Slave (Werkudara).

#### Yudhistira
```
echo '
zone "arjuna.E15.com" {
        type master;
        also-notify { 10.44.1.2; }; // IP Werkudara
    allow-transfer { 10.44.1.2; }; // IP Werkudara
        file "/etc/bind/jarkom/arjuna.E15.com";
};

zone "abimanyu.E15.com" {
        type master;
        also-notify { 10.44.1.2; }; // IP Werkudara
    allow-transfer { 10.44.1.2; }; // IP Werkudara
        file "/etc/bind/jarkom/abimanyu.E15.com";
};

zone "3.44.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.44.10.in-addr.arpa";
};

service bind9 restart
service bind9 stop
```

#### Penjelasan :
1. `also-notify { 10.44.1.2; };`: Ini menunjukkan bahwa server DNS di IP 10.44.1.2 akan menerima notifikasi saat ada perubahan pada zona. Notifikasi digunakan untuk memberi tahu server lain bahwa terjadi perubahan pada zona, sehingga server lain dapat mengambil pembaruan tanpa harus menunggu interval polling yang dijadwalkan. Ini berguna dalam konfigurasi yang melibatkan beberapa server DNS.

2. `allow-transfer { 10.44.1.2; };`: Menentukan server yang diizinkan untuk mentransfer zona dari server ini. Dalam hal ini, hanya server dengan IP 10.44.1.2 yang diizinkan untuk mentransfer zona. Transfer zona adalah proses di mana server DNS mengirimkan salinan lengkap dari zona kepada server DNS lainnya. Pengaturan ini membatasi akses untuk mencegah transfer zona yang tidak diinginkan atau tidak sah.

#### DNS Slave (Werkudara)
```
echo '
zone "arjuna.E15.com" {
    type slave;
    masters { 10.44.1.3; }; // IP Yudhistira
    file "/var/lib/bind/arjuna.E15.com";
};

zone "abimanyu.E15.com" {
    type slave;
    masters { 10.44.1.3; }; // IP Yudhistira
    file "/var/lib/bind/abimanyu.E15.com";
};

' > /etc/bind/named.conf.local
service bind9 restart
```

#### Penjelasan :
1. `zone "arjuna.E15.com" { ... };`: Menetapkan zona "arjuna.E15.com" sebagai zona slave. Artinya, server DNS ini akan menerima salinan zona dari server master dengan IP 10.44.1.3.

   - `type slave;`: Menentukan bahwa ini adalah zona slave.
   - `masters { 10.44.1.3; };`: Menunjukkan IP dari server master yang akan memberikan salinan zona.
   - `file "/var/lib/bind/arjuna.E15.com";`: Menunjukkan lokasi file di mana zona tersebut akan disimpan pada server DNS ini.

2. `zone "abimanyu.E15.com" { ... };`: Sama seperti di atas, tetapi untuk zona "abimanyu.E15.com".

#### Nakula / Client yang lain 
```
ping abimanyu.a09.com -c 5
ping www.abimanyu.a09.com -c 5
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/53a2cfb9-c152-4033-aafe-99f27b2a48f4)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/2727523b-729f-4cbc-b134-61365f47b06c)

## 7. Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.
 
Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Untuk melakukan Delegasi subdomain. Kita memerlukan beberapa configurasi pada DNS Master dan DNS Slave. Kita juga memerlukan bantuan allow-query { any; }; pada `DNS Master dan Slave. Serta kita memerlukan NS karena NS digunakan untuk delegasi zona DNS untuk menggunakan authoritative name server yang diberikan.

#### Yudhistira
Pada DNS Master kita perlu menambahkan ``ns1 IN  A 10.44.3.2 ;```. Kita juga perlu mengaktifkan ```allow-query { any; };``` pada DNS Master
```
echo '
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
@       IN      A       10.44.3.2	; IP Abimanyu
www     IN      CNAME   abimanyu.E15.com.
parikesit IN      A     10.44.3.2	; IP Abimanyu
ns1             IN      A       10.44.3.2	; IP Abimanyu
baratayuda      IN      NS      ns1
@       IN      AAAA    ::1


' > /etc/bind/jarkom/abimanyu.E15.com


echo 'options {
        directory "/var/cache/bind";
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

service bind9 restart
```

#### Penjelasan :
1. `ns1 IN A 10.44.3.2;`: Ini menyatakan bahwa nama server `ns1` memiliki alamat IP 10.44.3.2. Ini adalah catatan A (Address) yang mengaitkan nama server dengan alamat IP.

2. `baratayuda IN NS ns1;`: Ini adalah catatan NS yang menunjukkan bahwa domain `baratayuda` memiliki Name Server dengan nama `ns1`. Dengan kata lain, `ns1` adalah authority untuk zona `baratayuda`.

Dengan tambahan ini, server DNS akan tahu bahwa `ns1` memiliki alamat IP 10.44.3.2, dan `baratayuda` menggunakan `ns1` sebagai Name Server. Ini adalah bagian dari konfigurasi DNS yang membantu dalam mengarahkan permintaan DNS ke server yang benar.

3. `allow-query { any; };`: Ini adalah aturan akses yang memberikan izin kepada semua alamat IP (`any`) untuk melakukan pertanyaan (query) ke server DNS. Dengan kata lain, ini memperbolehkan server DNS untuk menerima permintaan dari siapa pun, tanpa membatasi alamat IP sumber.

#### Werkudara
Pada DNS Slave Kita perlu untuk mengarahkan zone ke DNS Master agar authoritative tadi dapat jalan. Kita juga perlu mengaktifkan ```allow-query { any; };``` pada DNS Slave.
```
echo 'options {
        directory "/var/cache/bind";
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

echo '
zone "baratayuda.abimanyu.E15.com" {
        type master;
        file "/etc/bind/Baratayuda/baratayuda.abimanyu.E15.com”;
};
' > /etc/bind/named.conf.local

mkdir /etc/bind/Baratayuda
cp /etc/bind/db.local /etc/bind/Baratayuda/baratayuda.abimanyu.E15.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.E15.com. root.baratayuda.abimanyu.E15.com. (
                        2023100901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.E15.com.
@       IN      A       10.44.3.2       ; IP Abimanyu
www	IN	CNAME	baratayuda.abimanyu.E15.com.
' > /etc/bind/Baratayuda/baratayuda.abimanyu.E15.com

service bind9 restart
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/01816614-0bf5-4d2d-bbe0-acb9310135d8)

## 8. Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Karena sebelumnya telah melakukan delegasi terhadap DNS Slave dan sekarang kita diberi perintah untuk melakukan subdomain terhadap delegasi domain tadi. Kita perlu untuk melakukan penambahan pada DNS Slave sebagai berikut:
```
rjp     IN      A       10.44.3.2       ; IP Abimanyu
www.rjp IN      CNAME   rjp
```

#### Werkudara
```
echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.E15.com. root.baratayuda.abimanyu.E15.com. (
                        2023100901      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      baratayuda.abimanyu.E15.com.
@       IN      A       10.44.1.2       ; IP Werkudara
www     IN      CNAME   baratayuda.abimanyu.E15.com.
rjp     IN      A       10.44.3.2       ; IP Abimanyu
www.rjp IN      CNAME   rjp
' > /etc/bind/Baratayuda/baratayuda.abimanyu.E15.com

service bind9 restart
```

#### Penjelasan :
1. `rjp IN A 10.44.3.2;`: Ini adalah catatan A (Address) yang mengaitkan nama host "rjp" dengan alamat IP 10.44.3.2.

2. `www.rjp IN CNAME rjp;`: Ini adalah catatan CNAME (Canonical Name) yang membuat alias "www.rjp" yang menunjuk ke nama host "rjp". Dengan kata lain, "www.rjp" adalah alias untuk host "rjp".

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/6cbb01f7-15bd-42f7-995e-2dca0287be4d)

## 9. Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

Mulailah dengan memastikan bahwa Arjuna telah dikonfigurasi dengan benar, termasuk konfigurasi Nginx dan peraturan load balancing yang sesuai. Pilih algoritma load balancing yang cocok dengan kebutuhan Anda, seperti round-robin atau algoritma lain yang sesuai.

Selanjutnya, lakukan penyebaran (deployment) pada setiap pekerja (worker). Ini melibatkan mengunggah aplikasi atau layanan web yang akan di-load balance ke setiap worker. Pastikan bahwa semua worker telah dikonfigurasi dengan benar dan siap untuk menangani lalu lintas web.

Setelah semua konfigurasi dan penyebaran selesai, Arjuna akan berfungsi sebagai load balancer yang mendistribusikan lalu lintas web ke worker yang tersedia.

#### Load balancer (Arjuna)
```
apt-get update
apt-get install lynx -y
apt-get install nginx -y


service nginx start

echo '
  upstream deploy  {
        server 10.44.3.2; #IP Abimanyu
        server 10.44.3.3; #IP Prabukusuma
        server 10.44.3.4; #IP Wisanggeni
 }

 server {
        listen 80;
        server_name arjuna.E15.com www.arjuna.E15.com;

        location / {
        proxy_pass http://deploy;
        }
 }
' > /etc/nginx/sites-available/lb-arjuna
ln -s /etc/nginx/sites-available/lb-arjuna /etc/nginx/sites-enabled
echo nameserver 10.44.1.3 > /etc/resolv.conf
rm -rf /etc/nginx/sites-enabled/default
service nginx restart
```

#### Penjelasan :
1. `apt-get update` dan `apt-get install lynx -y`:
   - Mengupdate daftar paket.
   - Menginstal lynx (web browser teks) secara otomatis dengan opsi `-y` untuk mengonfirmasi instalasi.

2. `apt-get install nginx -y`:
   - Menginstal server web Nginx dengan opsi `-y` untuk mengonfirmasi instalasi.

3. `service nginx start`:
   - Memulai layanan Nginx.

4. ```
   echo '
   upstream deploy  {
         server 10.44.3.2; #IP Abimanyu
         server 10.44.3.3; #IP Prabukusuma
         server 10.44.3.4; #IP Wisanggeni
   }

   server {
         listen 80;
         server_name arjuna.E15.com www.arjuna.E15.com;

         location / {
         proxy_pass http://deploy;
         }
   }
   ' > /etc/nginx/sites-available/lb-arjuna
   ```
   - Mendefinisikan blok `upstream` untuk menyimpan server-server yang akan di-load balance.
   - Konfigurasi server Nginx dengan nama `arjuna.E15.com` dan `www.arjuna.E15.com`.
   - Menggunakan `proxy_pass` untuk meneruskan permintaan ke server yang ditentukan dalam blok `upstream`.

5. `ln -s /etc/nginx/sites-available/lb-arjuna /etc/nginx/sites-enabled`:
   - Membuat symlink dari konfigurasi yang baru saja dibuat ke direktori `sites-enabled` untuk mengaktifkan konfigurasi tersebut.

6. `echo nameserver 10.44.1.3 > /etc/resolv.conf`:
   - Mengatur nameserver untuk resolusi DNS.

7. `rm -rf /etc/nginx/sites-enabled/default`:
   - Menghapus konfigurasi default yang dapat mengganggu konfigurasi load balancer.

8. `service nginx restart`:
   - Merestart layanan Nginx untuk menerapkan konfigurasi baru.

#### Prabukusuma, Abimanyu, Wisanggeni
```
apt-get update && apt install nginx php php-fpm -y
apt-get install lynx -y
mkdir /var/www/jarkom
echo '<?php
$hostname = gethostname();
$date = date('Y-m-d H:i:s');
$php_version = phpversion();
$username = get_current_user();

echo "Hello World!<br>";
echo "Saya adalah: $username<br>";
echo "Saat ini berada di: $hostname<br>";
echo "Versi PHP yang saya gunakan: $php_version<br>";
echo "Tanggal saat ini: $date<br>";
?>' > /var/www/jarkom/index.php
echo 'server {

 	listen 80;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

service php7.0-fpm start
ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default
service nginx restart
nginx -t
```

#### Penjelasan :
1. ```
   apt-get update && apt install nginx php php-fpm -y
   ```
   - Perintah ini bertujuan untuk mengupdate daftar paket dan menginstal Nginx, PHP, dan PHP-FPM secara otomatis.

2. ```
   apt-get install lynx -y
   ```
   - Menginstal lynx, web browser teks, yang mungkin diperlukan untuk keperluan pengujian atau manajemen server.

3. ```
   mkdir /var/www/jarkom
   ```
   - Membuat direktori `/var/www/jarkom` untuk menyimpan konten web.

4. ```
   echo '<?php
   $hostname = gethostname();
   $date = date('Y-m-d H:i:s');
   $php_version = phpversion();
   $username = get_current_user();

   echo "Hello World!<br>";
   echo "Saya adalah: $username<br>";
   echo "Saat ini berada di: $hostname<br>";
   echo "Versi PHP yang saya gunakan: $php_version<br>";
   echo "Tanggal saat ini: $date<br>";
   ?>' > /var/www/jarkom/index.php
   ```
   - Membuat file `index.php` dengan skrip PHP yang mencetak informasi dasar seperti nama host, waktu, versi PHP, dan nama pengguna.

5. ```
   echo 'server {
       listen 80;
       root /var/www/jarkom;
       index index.php index.html index.htm;
       server_name _;
       location / {
           try_files $uri $uri/ /index.php?$query_string;
       }
       # pass PHP scripts to FastCGI server
       location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
       }
       location ~ /\.ht {
           deny all;
       }
       error_log /var/log/nginx/jarkom_error.log;
       access_log /var/log/nginx/jarkom_access.log;
   }' > /etc/nginx/sites-available/jarkom
   ```
   - Konfigurasi server Nginx untuk mengakses konten PHP.
   - `listen 80;`: Menetapkan server untuk mendengarkan pada port 80.
   - `root /var/www/jarkom;`: Menentukan direktori root untuk file web.
   - `index index.php index.html index.htm;`: Menetapkan urutan indeks file.
   - Konfigurasi `location /` untuk mencoba file-file tertentu dan memanggil `index.php` jika tidak ada yang cocok.
   - Konfigurasi `location ~ \.php$` untuk meneruskan permintaan PHP ke server FastCGI.
   - `error_log` dan `access_log` menentukan lokasi file log.

6. ```
   service php7.0-fpm start
   ```
   - Memulai layanan PHP-FPM.

7. ```
   ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled
   ```
   - Membuat symlink dari konfigurasi yang baru saja dibuat ke direktori `sites-enabled` untuk mengaktifkan konfigurasi tersebut.

8. ```
   rm -rf /etc/nginx/sites-enabled/default
   ```
   - Menghapus konfigurasi default Nginx untuk mencegah konflik.

9. ```
   service nginx restart
   ```
   - Merestart layanan Nginx untuk menerapkan konfigurasi baru.

10. ```
   nginx -t
    ```
   - Memeriksa sintaks konfigurasi Nginx untuk memastikan tidak ada kesalahan.


#### Nakula / Client yang lain
//Testing
```
lynx http://10.44.3.2
lynx http://10.44.3.3
lynx http://10.44.3.4
lynx http://10.44.3.5
lynx http://arjuna.E15.com
```

## Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/d8a4ae90-9c26-44b3-8c14-198496a312f2)
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/366db409-13cc-4e12-889f-d4fd9fc13ca4)
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/87f251b4-1be8-4078-ad94-5591ca4c0326)

## 10. Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh
    - Prabakusuma:8001
    - Abimanyu:8002
    - Wisanggeni:8003

Sebelum mengerjakan perlu untuk melakukan setup terlebih dahulu. Karena telah berhasil melakukan deployment pada nomor 9. Hanya perlu mengubah masing-masing port pada worker menuju port yang telah ditentukan yaitu Prabakusuma:8001, Abimanyu:8002, Wisanggeni:8003. Kita juga perlu mengubah port load-balancing dengan menambahkan :800X pada masing-masing server. X adalah port yang telah ditentukan sesuai worker masing-masing.

#### Load Balancer (Arjuna)
```
echo '
  upstream deploy  {
        server 10.44.3.3:8001; #IP Prabukusuma
        server 10.44.3.2:8002; #IP Abimanyu
        server 10.44.3.4:8003; #IP Wisanggeni
 }

 server {
        listen 80;
        server_name arjuna.E15.com www.arjuna.E15.com;

        location / {
        proxy_pass http://deploy;
        }
 }
' > /etc/nginx/sites-available/lb-arjuna
ln -s /etc/nginx/sites-available/lb-arjuna /etc/nginx/sites-enabled
echo nameserver 10.44.1.3 > /etc/resolv.conf
rm -rf /etc/nginx/sites-enabled/default
service nginx restart
```

#### Prabukusuma, Abimanyu, Wisanggeni
X adalah port yang telah ditentukan sesuai worker masing-masing. 
```
echo 'server {

 	listen 800X;

 	root /var/www/jarkom;

 	index index.php index.html index.htm;
 	server_name _;

 	location / {
 			try_files $uri $uri/ /index.php?$query_string;
 	}

 	# pass PHP scripts to FastCGI server
 	location ~ \.php$ {
 	include snippets/fastcgi-php.conf;
 	fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
 	}

 location ~ /\.ht {
 			deny all;
 	}

 	error_log /var/log/nginx/jarkom_error.log;
 	access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

service php7.0-fpm start
ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default
service nginx restart
nginx -t
```

### Hasil :
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/d8a4ae90-9c26-44b3-8c14-198496a312f2)
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/366db409-13cc-4e12-889f-d4fd9fc13ca4)
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/87f251b4-1be8-4078-ad94-5591ca4c0326)
![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/106955551/6480740d-1b59-4712-830f-b22c8f41c94b)

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

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/decb668f-31b7-40e1-8056-8f778bd9e48d)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/b46c05b1-bc1a-47f8-9acf-4c495a99d4f0)


lynx parikesit.abimanyu.E15.com/public/images/not-abimanyu.png

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/76fc8f58-6229-4797-b37f-2f12f8de9c61)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/ebd74d97-6082-4ab1-9598-48660cfe08e5)

![image](https://github.com/weynard02/Jarkom-Modul-2-E15-2023/assets/90879937/4c35c157-0e07-4214-a619-18dee1d88470)



## Kendala:
- Pada nomor 11, sempat kesulitan mengapa saat apache2 direstart, membuat error bahwa port 80 sudah dipakai padahal baru pertama kali jalan. Ternyata masalahnya adalah page default nginx (yang menggunakan port80) belum diremove
- Pada nomor 13, sempat kesulitan mengapa alias tidak berjalan (www.parikesit.abimanyu.E15.com). Ternyata karena soal sebelumnya tidak diminta membuat aliasnya sehingga belum dibuat pada DNS-Masternya
- Terdapat beberapa konfigurasi di luar modul, sehingga perlu mencari tau melalui google (ErrorDocument, htpasswd, RedirectPermanent, dll)
