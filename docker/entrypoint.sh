#!/bin/sh
cd /home/L
git pull
npm install
supervisord -c /etc/supervisor/conf.d/l.conf
