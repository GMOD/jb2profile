#!/bin/bash
set -e
[ ! -d "jb2_165" ] && jbrowse create --tag v1.6.5 jb2_165
[ ! -d "jb2_167" ] && jbrowse create --tag v1.6.7 jb2_167
[ ! -d "jb2optim1" ] || [  $FORCE  ] && rm -rf jb2optim1 && jbrowse create --branch slightly_faster_cigar_parsing jb2optim1 && rm -rf jb2optim1/config.json
[ ! -d "jb2optim2" ] || [ $FORCE ] && rm -rf jb2optim2 && jbrowse create --branch optimizations jb2optim2 && rm -rf jb2optim2/config.json

sudo apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm1

npm install -g yarn

yarn
if [ ! -d "igv.js" ]; then
      	git clone https://github.com/cmdcolin/igv.js
	cd igv.js
	yarn
	yarn build
	yarn link
	cd ..
	cd igvjs
	yarn link igv
	cd ..
fi
yarn workspaces run build
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam.bai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram.crai

samtools view -T volvox.fa badread.1000x.cram -o badread.1000x.bam 
samtools index badread.1000x.bam
samtools view -T volvox.fa badread.50x.cram -o badread.50x.bam 
samtools index badread.50x.bam

for j in jb2_165 jb2_167 jb2optim1 jb2optim2; do
  jbrowse add-assembly --load copy volvox.fa --out $j --force
  for i in volvox-wgsim.{bam,cram} badread.1000x.{bam,cram} badread.50x.{cram,bam} volvox-sorted.{bam,cram}; do
    echo $i $j
    jbrowse add-track $i --load copy --out $j --trackId $i --force
  done;
done;

## copy files to igv and @jbrowse/react-linear-genome-view demos
for i in volvox.fa volvox-sorted volvox-wgsim badread.1000x badread.50x volvox-sorted; do
  for j in {jb2lgv,igvjs}; do
    echo $i $j
    cp $i* $j/build
  done;
done;

