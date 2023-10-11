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
