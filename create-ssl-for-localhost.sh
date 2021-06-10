#!/usr/bin/env bash

echo " "
echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
echo " *  Usage: "
echo " *  ./create-ssl-for-localhost.sh {name of project} {domain.extension} {workspace or project folder}"
echo " *  "

if [[ -z "$1" ]]; then
    echo " *  [ERROR] name of project is required, try: localhost"
	exit 1
else
    NAME=$1
fi

if [[ -z "$2" ]]; then
    echo " *  [ERROR] domain name is required, try: localhost.local"
	exit 1
else
    DOMAIN=$2
fi

if [[ -z "$3" ]]; then
    echo " *  [ERROR] project folder is required"
	exit 1
else
    WORKSPACE=$3
fi

echo " *  [INFO] Creating CSR file"
if sudo openssl req -new -newkey rsa:2048 -nodes -keyout /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.key -out /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.csr  -subj "/C=AR/ST=BUE/L=BUE/O=UVOD/OU=DEV/CN=$DOMAIN" | grep -q "error" ; then
    return 1;
fi

#sudo touch /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.ext
sudo echo "authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAIN
" > /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.ext

echo " *  [INFO] Creating CRT file"
if sudo openssl x509 -req -sha256 -extfile /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.ext -days 3650 -in /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.csr -signkey /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.key -out /Applications/XAMPP/xamppfiles/etc/ssl/$NAME.crt | grep -q "error" ; then
    return 1;
fi

echo " *  [INFO] Adding virtual host to vhost.conf"
sudo echo "
<VirtualHost *:443>
    ServerName $DOMAIN
    DocumentRoot \"/Applications/XAMPP/xamppfiles/htdocs/$WORKSPACE\"
    SSLEngine on
    SSLCertificateFile \"/Applications/XAMPP/xamppfiles/etc/ssl/$DOMAIN.crt\"
    SSLCertificateKeyFile \"/Applications/XAMPP/xamppfiles/etc/ssl/$DOMAIN.key\"
    ErrorLog \"logs/$DOMAIN-error_log\"
    CustomLog \"logs/$DOMAIN-access_log\" common
</VirtualHost>
" >> /Applications/XAMPP/xamppfiles/etc/extra/httpd-vhosts.conf

echo " *  [WARN] Mac OS users, check point 8: https://tidus.dev/xampp-https-ssl-localhost"
echo " *  [INFO] DONE"
# Mac OS users, check point 8: https://tidus.dev/xampp-https-ssl-localhost
echo " * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
echo " "
