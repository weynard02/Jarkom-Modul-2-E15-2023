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

zone "3.44.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.44.10.in-addr.arpa";
};

' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.E15.com
cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.E15.com
cp /etc/bind/db.local /etc/bind/jarkom/3.44.10.in-addr.arpa

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
@         IN      NS      abimanyu.E15.com.
@         IN      A       10.44.3.2
www       IN      CNAME   abimanyu.E15.com.
parikesit IN      A              10.44.3.2
@           IN      AAAA    ::1

' > /etc/bind/jarkom/abimanyu.E15.com

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
