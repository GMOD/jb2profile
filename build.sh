#!/bin/bash
set -e
[ ! -d "jb2_165" ] && jbrowse create --tag v1.6.5 jb2_165
[ ! -d "jb2_167" ] && jbrowse create --tag v1.6.7 jb2_167
[ ! -d "jb2_169" ] && jbrowse create --tag v1.6.9 jb2_169
[ ! -d "jb2_main" ] && jbrowse create --branch main jb2_main
[ ! -d "jb2_noserialize" ] && rm -rf jb2_noserialize && jbrowse create --branch async_feature_details jb2_noserialize && rm -rf jb2_noserialize/config.json

sudo apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm1 python3 python3-pip

pip3 install git+https://github.com/rrwick/Badread.git


npm install -g yarn
npm install -g @jbrowse/img
npm install -g @jbrowse/cli

yarn
if [ ! -d "igv.js" ]; then
  git clone https://github.com/cmdcolin/igv.js
  cd igv.js
  yarn
  yarn build
  yarn link
  cd -
  yarn link igv
fi
yarn workspaces run build

