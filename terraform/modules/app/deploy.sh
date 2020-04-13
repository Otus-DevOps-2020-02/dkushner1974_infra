#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

if [ ! -d $APP_DIR/reddit ]
then
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
fi

#sudo sed -i "s/changeOnDeploy/$DB_IP/" /tmp/puma.service
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl restart puma
sudo systemctl enable puma
