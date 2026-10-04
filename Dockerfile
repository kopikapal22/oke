FROM alpine:latest

# Install Nginx, Xray dependencies, wget, unzip, gettext
RUN apk add --no-cache nginx ca-certificates wget unzip gettext

# Install Xray core
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/bin/ && \
    rm /tmp/xray.zip && \
    chmod +x /usr/bin/xray

# Copy file konfigurasi & script
COPY xray-config.template.json /etc/xray/config.template.json
COPY nginx.template.conf /etc/nginx/nginx.template.conf
COPY index.template.html /usr/share/nginx/html/index.template.html
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
