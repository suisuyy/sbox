
#  curl -s   https://raw.githubusercontent.com/suisuyy/sbox/master/test/keepalive.sh | bash 3 

# Loop through the URLs indefinitely
while true
do
  curl -s   https://raw.githubusercontent.com/suisuyy/sbox/master/test/awake.sh | bash
  sleep $1  # Wait for 10 seconds before sending the next request
  
done 
