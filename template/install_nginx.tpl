#!/bin/bash
set -e

BUCKET_NAME=${bucket_name}
WEBPAGE_PATH=${webpage_path}

echo "*****    Installing Nginx    *****"
apt update
apt install -y nginx
ufw allow '${ufw_allow_nginx}'
systemctl enable nginx
systemctl restart nginx

echo "*****   Installation Complteted!!   *****"

echo "*****   Getting Webpage from GCS    *****"
gsutil cp gs://$BUCKET_NAME/$WEBPAGE_PATH /var/www/html/


echo "*****   Startup script completes!!    *****"
