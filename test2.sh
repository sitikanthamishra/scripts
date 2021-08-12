echo "<html>"
echo "<table border=\"2\" BORDERCOLOR=\"BLUE\" cellpadding=\"2\">"
printf "<tr><td colspan=\"10\"><font color=\"#177621\" size=\"6\"><b><center>Resource Utilization of EC2</center></b></font></td></tr>"
echo "<tr><td></td>"
for value in NODE  IP CPU\(\%\)   Memory\(\%\)   Swap\(\%\)  Disk\(\%\);do
    echo "<th><font color=\"#72411A\"><font size=\"5\"><b>$value</b></font></th>"
done

echo "</tr>"
for server in `cat /root/nodes|awk '{print $1}'`
do
     snode=$(ssh $server hostname)
     sip=$(ssh $server ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'| grep  -v '127.0.0.1')
     scpu=$(ssh $server cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1)
     smem=$(ssh $server free | awk '/Mem/{printf("%.2f%"), $3/$2*100}')
     sswap=$(ssh $server free | awk '/Swap/{printf("%.2f%"), $3/$2*100}')
     sdf=$(ssh $server df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }')
        echo  "<td><font size=\"2\"></td>"
        echo  "<td><font size=\"2\">$snode</td>"
        echo  "<td><font size=\"2\">$sip</td>"
        echo  "<td><font size=\"2\">$scpu</td>"
        echo  "<td><foot size=\"2\">$smem</td>"
	echo  "<td><foot size=\"2\">$sswap</td>"
	echo  "<td><foot size=\"2\">$sdf</td>"
        echo "</tr>"
done
        echo "</table>"
echo "</html>"
