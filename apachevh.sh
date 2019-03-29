###################################################################
#                                                                 #
#             SCriptura automatizare VH Apache2                   #
#               Maintained by Nicu                                #
#                                                                 #
###################################################################

#!/bin/bash


read -p "Introduceti numele de utilizator(numele de domeniu)" usr


read -p "Introduceti directorul dorit (/var/www/$usr)" homedir



read -p "Introduceti numele serverului (domain name, pornhub.com, debian.org)" sn


read -p "Email ServerAdmin" se




# Face director web si o pagina de index.php

mkdir $homedir

cd $homedir

mkdir $sn

cd $homedir/$sn

mkdir "public_html"

cd $homedir/$sn/public_html

echo "<?php echo '<h1>$2</h1>'; ?>" > $homedir/$sn/public_html/index.php



# Seteaza ownership

chown -R ftpuser:www-data $homedir/

chown -R ftpuser:www-data $homedir/$sn/

chmod -R '755' $homedir

chmod -R '755' $homedir/$sn/public_html





# Monotorizeaza logs

mkdir /var/log/apache2/$sn/





# Creaza virtual hosts in /etc/apache2/site-available/

echo "<VirtualHost *:80>

        ServerAdmin $se

        ServerName $sn

        ServerAlias www.$sn



        DocumentRoot $homedir/$sn/public_html/

        <Directory />

                Options FollowSymLinks

                AllowOverride All

        </Directory>

        <Directory $homedir/$sn/public_html/>

                Options Indexes FollowSymLinks MultiViews

                AllowOverride All

                Order allow,deny

                allow from all

        </Directory>



        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/

        <Directory "'/usr/lib/cgi-bin'">

                AllowOverride All

                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch

                Order allow,deny

                Allow from all

        </Directory>



        ErrorLog /var/log/apache2/$sn/error.log



        # Possible values include: debug, info, notice, warn, error, crit,

        # alert, emerg.

        LogLevel warn



        CustomLog /var/log/apache2/$sn/access.log combined



    Alias /doc/ "'/usr/share/doc/'"

    <Directory "'/usr/share/doc/'">

        Options Indexes MultiViews FollowSymLinks

        AllowOverride All

        Order deny,allow

        Deny from all

        Allow from 127.0.0.0/255.0.0.0 ::1/128

    </Directory>



</VirtualHost>" > /etc/apache2/sites-available/$sn.conf





# Adaug host

echo 127.0.0.1 $sn >> /etc/hosts





# Activez site
cd /etc/apache2/sites-available/
a2ensite $sn



# Reload Apache2---nu merge

systemctl restart apache2

# Vad log system

tail /var/log/syslog
