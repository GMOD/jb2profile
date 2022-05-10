#!/bin/bash
set -e
[ ! -d "jb2_175" ] && jbrowse create --tag v1.7.5 jb2_175

sudo apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm1 python3 python3-pip unzip

[ ! -d "express_cross_origin_isolated" ] && git clone git@github.com:cmdcolin/express_cross_origin_isolated.git

npm install -g yarn
# npm install -g @jbrowse/img
# npm install -g @jbrowse/cli


if [ ! -d "jbrowse" ]; then
  wget https://github.com/GMOD/jbrowse/releases/download/1.16.11-release/JBrowse-1.16.11.zip
  unzip JBrowse-1.16.11.zip
  mv JBrowse-1.16.11 jbrowse
  cd jbrowse
  ./setup.sh
  cd -
fi

if [ ! -d "igv.js" ]; then
  git clone https://github.com/cmdcolin/igv.js
  cd igv.js
  yarn
  yarn build
  yarn link
  cd -
  yarn link igv
fi

yarn
yarn workspaces run build

