 sudo cp systemd/system/v2ray.service /etc/systemd/system/
 sudo systemctl daemon-reload 
 sudo systemctl enable --now v2ray.service 
 sleep 2
 sudo systemctl status v2ray.service 
