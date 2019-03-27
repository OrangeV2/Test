echo "############################################################################## "
echo "#              Maintained by slt.ing.NicolaeBucica                           # "
echo "#                      Automatizarea zonei Bind9                             # "
echo "############################################################################## "
read -p "nume_domeniu:" nume_domeniu
read -p "WWWIP:" WWWIP
read -p "Nameserver:" nameserver
read -p "IP_NS:" IP_NS
read -p "Doriti Server De Mail?(y/n) " input

echo "\$TTL 86400;"
###### sincepe SOA ######
#echo "\$ORIGIN ${nume_domeniu}."
echo "@       IN      SOA     ${nameserver} admin.${nume_domeniu} ("
echo "                1        "
echo "             604800      "
echo "              86400      "
echo "            2419200      "
echo "             604800 )    "
echo ":----------------------------------------------------"
echo " ;Definirea nameserverelor"
echo "@         IN      NS      ${nameserver}."
echo " ;"
if [ "$input" == "y" ];
        then
        echo " ;--------------------------------------------"
        echo " ;Definirea serverului de mail "
        echo " @ IN  MX 10 mx.${nume_domeniu}. "
        else
        echo ""
fi
echo ""
echo ""
echo ";--------------------------------------------------"
echo " ; registrari tip A "
echo " @                 IN      A       ${WWWIP} "
echo " ns                IN      A       ${IP_NS}"
echo " www               IN      A       ${WWWIP} "
if [ "$input" == "y" ];
        then
        echo " MX        IN      A       10 ${WWWIP} "
        else
        echo ""
fi
