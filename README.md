# Freifunk-chchmesh.sh
Automatische Kanalwahl abh. v. Mesh-Status auf WAN

V0.9 getestet auf 841 V9 mit FFFFM v1.10.2-test-78, Kanalwechsel klappt
V0.91 noch nicht erfolgreich getestet, Clientverbindung kommt auf neuem Kanal nicht zufriedenstellend zustande (IPV6 geht wohl, IPV4 scheinbar nich)

(nicht zusammen mit wificheck.sh betreiben)

Die Konstellation, für die das ist, ist die, dass außen am Gebäude zB eine CPE hängt (die von irgendwoher Freifunk bezieht), und innen im Container ein 841 steht, um Freifunk dort an die Nutzer zu verteilen.
Wenn die beiden idealerweise über Kabel meshen, kann der 841 mittels chchmesh.sh selbst den Kanal wechseln, um den Standardkanal weniger zu belasten.
Falls jemand den 841 aber woanders hinstellt und dazu das Netzwerkkabel abmacht, dann wechselt der 841 mittels chchmesh.sh automatisch zurück auf Kanal 1, um wieder über WLAN meshen zu können.
