
# Define the URLs
urls=(
  "https://devilent-alistn.hf.space/"
  "https://devilent-codeserver4.hf.space"
  "https://devilent-testvv.hf.space"
  "https://studious-halibut-9jgx5qvwj4rh9pr7.github.dev/"
)

# Loop through the URLs indefinitely
  for url in "${urls[@]}"
  do
    echo "Sending request to $url"
    curl  --max-time 10 "$url" >/dev/null
    echo $?
  done
  sleep 1  # Wait for 10 seconds before sending the next request
  
