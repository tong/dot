geoloc() {
  curl -s "http://ip-api.com/json/$1" | jq -r '
      if .status == "success" then
          to_entries | .[] | "\(.key): \(.value)"
      else
          "Error: \(.message)"
      end
  '
}
