#DNSMASTER Yudhistira
auto eth0
iface eth0 inet static
	address 10.44.1.3
	netmask 255.255.255.0
	gateway 10.44.1.1

#DNSSLAVE-Werkudara
auto eth0
iface eth0 inet static
	address 10.44.1.2
	netmask 255.255.255.0
	gateway 10.44.1.1

#Pandudewanata
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.44.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.44.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.44.3.1


#Abimanyu
auto eth0
iface eth0 inet static
	address 10.44.3.2
	netmask 255.255.255.0
	gateway 10.44.3.1

#Prabukusuma
auto eth0
iface eth0 inet static
	address 10.44.3.3
	netmask 255.255.255.0
	gateway 10.44.3.1

#Wisanggeni
auto eth0
iface eth0 inet static
	address 10.44.3.4
	netmask 255.255.255.0
	gateway 10.44.3.1

#LB-ARJUNA
auto eth0
iface eth0 inet static
	address 10.44.3.5
	netmask 255.255.255.0
	gateway 10.44.3.1

#Client-Nakula
auto eth0
iface eth0 inet static
	address 10.44.2.2
	netmask 255.255.255.0
	gateway 10.44.2.1

#Client-Sadewa
auto eth0
iface eth0 inet static
	address 10.44.2.3
	netmask 255.255.255.0
	gateway 10.44.2.1