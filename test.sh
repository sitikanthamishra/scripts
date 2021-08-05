echo "<html>"
echo "<table border=\"2\" BORDERCOLOR=\"BLUE\" cellpadding=\"2\">"
printf "<tr><td colspan=\"10\"><font color=\"#177621\" size=\"6\"><b><center>Kafka Disk Utilization  Status</center></b></font></td></tr>"
echo "<tr><td></td>"
for value in NODE  Disk_Usage_Per_Day_In_MB init_size_In_MB max_size_In_MB;do
    echo "<th><font color=\"#72411A\"><font size=\"5\"><b>$value</b></font></th>"
done

echo "</tr>"

for i in  `cat /root/nodes | awk '{print $1}'`; do
  ssh -t -q -o StrictHostKeyChecking=no -o  ConnectTimeout=10 -o ConnectionAttempts=1 root@$i '''
        NODE=$(hostname)
        MS=$(cat /tmp/sto-$(date  --date="today" +"%F")|awk  "{print \$4}"|tr -d M;)
        TU=$(cat /tmp/sto-$(date  --date="today" +"%F")|awk  "{print \$3}"|tr -d M;)
	YU=$(cat /tmp/sto-$(date  --date="yesterday" +"%F")|awk  "{print \$3}"|tr -d M;)
        CH=$(echo $TU - $YU | bc)
        printf  "<td><font size=\"2\"></td>"
        printf  "<td><font size=\"2\">$NODE</td>"
        printf  "<td><font size=\"2\">$CH</td>"
        printf  "<td><foot size=\"2\">$YU</td>"
	printf  "<td><foot size=\"2\">$MS</td>"
        echo "</tr>"
		'''
done
        echo "</table>"
echo "</html>"
