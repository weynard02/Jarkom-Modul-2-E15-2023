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
