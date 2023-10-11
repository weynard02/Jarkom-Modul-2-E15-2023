echo 'options {
        directory "/var/cache/bind";
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

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
