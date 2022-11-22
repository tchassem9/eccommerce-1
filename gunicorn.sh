#!/bin/bash -x

##Kill any process running on 8000

fuser -k 8000/tcp
deactivate

cat << EOF >> /etc/systemd/system/gunicorn.socket
[Unit]
Description=gunicorn socket
[Socket]
ListenStream=/run/gunicorn.sock
[Install]
WantedBy=sockets.target
EOF

cat << EOF >> /etc/systemd/system/gunicorn.service
[Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target
[Service]
User=root
Group=www-data
WorkingDirectory=/root/eccommerce
ExecStart=/root/eccommerce/venv/bin/gunicorn --workers 3 --bind unix:/run/gunicorn.sock demo.wsgi:application
[Install]
WantedBy=multi-user.target
EOF

chown -R www-data:root ~/eccommerce
systemctl daemon-reload
systemctl start gunicorn.socket
systemctl enable gunicorn.socket
systemctl status gunicorn.socket

cat << EOF >> /etc/nginx/conf.d/django.conf
server {  
	listen 80;     
	server_name 192.168.56.154;    
	location = /favicon.ico { access_log off; log_not_found off; }    
	location /static_root/ {         
		root /root/eccommerce;     
	}    
	location / {         
		include proxy_params;         
		proxy_pass http://unix:/run/gunicorn.sock;     
	}
}

EOF
nginx -t
sudo ufw delete allow 8000
sudo ufw allow http/tcp
systemctl restart nginx

echo -e "\n\nconfiguration done please access the browser with your ip address and check if your app comes up. if not get with the developer to troubleshoot eventual issues\n"
sleep 10
