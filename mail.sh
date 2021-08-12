{
        echo "Subject: [Report]: EC2  Status for $(date +%F_%H-%M-%S)"
        echo "To: ashaa@gtv.org"
        echo "MIME-Version: 1.0"
        echo "Content-Type: text/html"
        echo "Content-Disposition: inline"
        cat 
} | /usr/sbin/sendmail -F "" -r  -t
