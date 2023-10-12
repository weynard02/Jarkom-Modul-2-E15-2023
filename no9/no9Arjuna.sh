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
service nginx restart
