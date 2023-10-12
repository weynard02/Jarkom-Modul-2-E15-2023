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
service nginx restar

# lynx arjuna.E15.com
# lynx www.arjuna.E15.com
# lynx 10.44.3.5.com
