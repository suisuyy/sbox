unzip ./novnc1.3.0.zip
sudo apt update 
sudo apt install -y ./turbovnc_3.0.1_amd64.deb ./n2n_3.0.0-1038_amd64.deb  gcc  fonts-wqy-zenhei firefox  xorg xfce4  xterm

sudo edge -r -z1 -c suinet -k 080797ssY -a 192.168.100.200 -f -l 15.152.37.220:7777 -E 

 /opt/TurboVNC/bin/vncserver -novnc ./noVNC-1.3.0/

 # open http://192.168.100.200:5801/vnc.html?host=192.168.100.200&port=5901&password=080797ssY