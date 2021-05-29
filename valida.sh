#!/bin/bash
URL=$(cat sites.txt)
echo "<!DOCTYPE html>"
echo "<html lang='pt-br'>"
echo "   <head>"
echo "      <meta charset='UTF-8'>"
echo "      <title>MONITORAÇÃO | MIDDLEWARE</title>"
echo "   </head>"
echo "   <body align='center'>"
echo "      <font size='5' face='Tahoma, Verdana, Arial, Helvetica, sans-serif' color='red'>"
echo "         <h3>Validações de WebSites</h3>"
echo "      </font>"
echo "      <div align='center'>"
echo "        <Table border=0 cellpadding=1 cellspacing=5>"
echo "            <TR bgcolor=red align=center>"
echo "                    <TD><FONT COLOR=white>URL</TD>"
echo "                    <TD><FONT COLOR=white>STATUS CODE</TD>"
echo "                    <TD><FONT COLOR=white>STATUS</TD>"
echo "                    <TD><FONT COLOR=white>TIME TAKEN</TD>"
echo "                    <TD><FONT COLOR=white>DATA</TD>"
echo "                </TR>"
for i in $URL; do
DATA=$(date)
echo "                  <TD align=center>" $i "</TD>"
http_resp=`curl $i -o /dev/null -s -w "%{http_code} %{time_total}"`
http_code=`echo $http_resp | awk -F" " '{ print $1}'`
http_time=`echo $http_resp | awk -F" " '{ print $2}'`
if [ $http_code == "200" ] || [ $http_code == "301" ]; then
echo "                  <TD align=center> $http_code </TD>"
echo "                  <TD align=center bgcolor=green><FONT COLOR=white> RUNNING </TD>"
else
echo "                  <TD align=center> $http_code </TD>"
echo "                  <TD align=center bgcolor=red><FONT COLOR=white> NOK </TD>"
fi
echo "                  <TD align=center> $http_time </TD>"
echo "                  <TD align=center>" $DATA "</TD></TR>"
done
echo "            </TR>"
echo "        </Table>"
echo "      </div>"
echo "   </body>"
echo "</html>"
