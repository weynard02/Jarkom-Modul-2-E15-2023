apt-get update
apt-get install lynx -y

echo 'nameserver 10.44.1.3
nameserver 10.44.1.2' > /etc/resolv.conf

# lynx http://10.44.3.3:8001
# lynx http://10.44.3.2:8002
# lynx http://10.44.3.4:8003