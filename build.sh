#!/bin/bash
set -e
sudo apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm1 python3 python3-pip unzip minimap2 libcurl4-openssl-dev hyperfine

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

## not from apt, need libcurl
if [ ! -d "samtools" ]; then
  wget https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2
  tar xf samtools-1.15.1.tar.bz2
  cd samtools-1.15.1
  ./configure --without-curses --disable-bz2 --disable-lzma --with-libcurl
  make -j8
  sudo make install
  cd -
fi;


if [ ! -d "pbsim2" ]; then
  git clone https://github.com/yukiteruono/pbsim2
  cd pbsim2
  ./configure
  make
  sudo make install
  cd -
fi;

sudo npm install -g yarn
# npm install -g @jbrowse/img
sudo npm install -g @jbrowse/cli


if [ ! -d "jbrowse" ]; then
  wget https://github.com/GMOD/jbrowse/releases/download/1.16.11-release/JBrowse-1.16.11.zip
  unzip JBrowse-1.16.11.zip
  mv JBrowse-1.16.11 jbrowse
  cd jbrowse
  ./setup.sh
  cd -
fi

[ ! -d "jb2_175" ] && jbrowse create --tag v1.7.5 jb2_175
[ ! -d "jb2mod" ] && jbrowse create --branch main jb2mod


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

