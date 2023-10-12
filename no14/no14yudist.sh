echo ';
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
@       IN      AAAA    ::1' > /etc/bind/jarkom/abimanyu.E15.com