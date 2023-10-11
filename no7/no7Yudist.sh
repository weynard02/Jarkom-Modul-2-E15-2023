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

echo '
zone "arjuna.E15.com" {
        type master;
        also-notify { 10.44.1.2; }; // IP Werkudara
    allow-transfer { 10.44.1.2; }; // IP Werkudara
        file "/etc/bind/jarkom/arjuna.E15.com";
};

zone "abimanyu.E15.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.E15.com";
        allow-transfer { 10.44.1.2; }; // IP Werkudara
};

zone "3.44.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.44.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

service bind9 restart


