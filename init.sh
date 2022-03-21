#!/bin/bash
set -e
[ ! -d "jb2_165" ] && jbrowse create --tag v1.6.5 jb2_165
[ ! -d "jb2_167" ] && jbrowse create --tag v1.6.7 jb2_167
[ ! -d "jb2optim1" ] || [ $FORCE ] && rm -rf jb2optim1 && jbrowse create --branch slightly_faster_cigar_parsing jb2optim1 && rm -rf jb2optim1/config.json
[ ! -d "jb2optim2" ] || [ $FORCE ] && rm -rf jb2optim2 && jbrowse create --branch optimizations jb2optim2 && rm -rf jb2optim2/config.json

sudo apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm1

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
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam.bai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram.crai
wget -N https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz
wget -N https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz.fai
wget -N https://jbrowse.org/genomes/hg19/fasta/hg19.fa.gz.gzi

## download only chr22 of human data
if [ ! -f "ultra-long-ont_hs37d5_phased.cram" ]; then
  samtools view 'https://s3.amazonaws.com/jbrowse.org/genomes/hg19/ultra-long-ont_hs37d5_phased.cram' 22 -o ultra-long-ont_hs37d5_phased.cram
fi;


if [ ! -f "badread.1000x.bam" ]; then
  samtools view -T volvox.fa badread.1000x.cram -o badread.1000x.bam 
  samtools index badread.1000x.bam
fi;
if [ ! -f "badread.50x.bam" ]; then
  samtools view -T volvox.fa badread.50x.cram -o badread.50x.bam 
  samtools index badread.50x.bam
fi;
if [ ! -f "ultra-long-ont_hs37d5_phased.bam" ]; then
  echo "Converting ultralong to BAM"
  samtools view -T hg19.fa.gz ultra-long-ont_hs37d5_phased.cram -o ultra-long-ont_hs37d5_phased.bam
  samtools index ultra-long-ont_hs37d5_phased.bam
fi;

for j in jb2_165 jb2_167 jb2_main jb2optim1 jb2optim2; do
  jbrowse add-assembly --load copy volvox.fa --out $j --force
  jbrowse add-assembly --load copy hg19.fa.gz --out $j --force
  for i in volvox-wgsim.{bam,cram} badread.1000x.{bam,cram} badread.50x.{cram,bam} volvox-sorted.{bam,cram}; do
    echo $i $j
    jbrowse add-track $i --load copy --out $j --trackId $i --force -a volvox
  done;

  for i in ultra-long-ont_hs37d5_phased.{bam,cram}; do
    jbrowse add-track $i --load symlink --out $j --trackId $i --force -a hg19
  done;
done;

## copy files to igv and @jbrowse/react-linear-genome-view demos
for i in volvox.fa volvox-wgsim badread.1000x badread.50x volvox-sorted ultra-long-ont_hs37d5_phased; do
  for j in {jb2lgv,igvjs}; do
    for k in $i*; do
      echo $i $j
      rm -f $j/build/$k
      ln -s ../../$k $j/build/$k
    done;
  done;
done;

