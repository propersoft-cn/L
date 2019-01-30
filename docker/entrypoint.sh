#!/bin/bash
npm install
git pull
supervisord -c /etc/supervisor/conf.d/l.conf
