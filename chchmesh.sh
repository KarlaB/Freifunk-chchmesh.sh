#!/bin/sh

#####################################################
## Automatische Kanalwahl abh. v. Mesh-Status auf WAN
## (nicht zusammen mit wificheck.sh betreiben)
## V0.9 getestet auf 841 V9 mit FFFFM v1.10.2-test-78
#####################################################
## Info zum Cron-Job:
## Aufruf von:
## crontab -e
##
## folgenden Inhalt einfuegen:
## */1 * * * * /root/chchmesh.sh
##
## (und ggf die Zeile mit wificheck.sh loeschen)
## und Cron neu starten:
## /etc/init.d/cron restart
#####################################################
## Dann:
## chmod +x chchmesh.sh
#####################################################
## Die Datei updatesicher machen:
## in /etc/sysupgrade.conf
## folgendes eintragen:
## /root/
#####################################################

NOW=$(date)
act_ch=$(uci show wireless.radio0.channel | cut -d\' -f2)
echo Aktueller Kanal: $act_ch
mesh_ch="1"
clientonly_ch="6"
MoW=$(nodeinfo | grep br-wan: | cut -d\: -f2 | cut -c2-)

if [ "$MoW" == "active" ]
 then
  echo  $NOW - MoW aktiv, Wifi-Mesh nicht noetig.
    if [ "$act_ch" == "$clientonly_ch" ]
     then
       echo Kanal passt, alles gut.
     else
      echo Wechsele von Kanal $act_ch zu $clientonly_ch 
      echo  $NOW - MoW aktiv, wechsele Kanal $act_ch zu $clientonly_ch  >> /tmp/log/chchmesh
      uci set wireless.radio0.channel=$clientonly_ch
      uci commit wireless
      wifi
    fi
 else
   echo  $NOW - MoW inaktiv, Wifi-Mesh noetig.
    if [ "$act_ch" == "$mesh_ch" ]
     then
	echo Kanal passt, alles gut.
     else
       echo Wechsle von Kanal $act_ch zu $mesh_ch
       echo  $NOW - MoW inaktiv, wechsele Kanal von $act_ch zu $mesh_ch >> /tmp/log/chchmesh
       uci set wireless.radio0.channel=$mesh_ch
       uci commit wireless
       wifi
     fi
fi

