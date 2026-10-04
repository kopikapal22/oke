#!/bin/sh

# Set default UUID jika variabel lingkungan UUID tidak diisi
if [ -z "$UUID" ]; then
    export UUID="de0b9bab-626a-484d-9f67-cb7fc2272384"
fi

# Render file template dengan variabel lingkungan (\(PORT dan\)UUID)
envsubst '${PORT}' < /etc/nginx/nginx.template.conf > /etc/nginx/nginx.conf
envsubst '${UUID}' < /etc/xray/config.template.json > /etc/xray/config.json
envsubst '${UUID}' < /usr/share/nginx/html/index.template.html > /usr/share/nginx/html/index.html

# Jalankan Xray core di background
/usr/bin/xray -config /etc/xray/config.json &

# Jalankan Nginx di foreground
echo "Starting Nginx Gateway with UI Generator on PORT: $PORT..."
exec nginx -g 'daemon off;'
