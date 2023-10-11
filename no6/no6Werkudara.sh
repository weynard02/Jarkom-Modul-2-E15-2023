apt-get update
apt-get install bind9 -y

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
