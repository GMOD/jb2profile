#!/bin/bash
set -e
rm -rf jb2web
jbrowse create --tag v1.6.5 jb2web
yarn workspaces run build
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam.bai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram.crai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram.crai

samtools view badread.1000x.cram -o badread.1000x.bam 
samtools index badread.1000x.bam
samtools view badread.50x.cram -o badread.50x.bam 
samtools index badread.50x.bam

## setup jb2web_optim
jbrowse add-assembly --load copy volvox.fa --out jb2web --force
jbrowse add-assembly --load copy volvox.fa --out jb2web_optim --force
for i in volvox-wgsim.{bam,cram} badread.1000x.{bam,cram} badread.50x.cram volvox-sorted.{bam,cram}; do
  echo $i
  jbrowse add-track $i --load copy --out jb2web --trackId $i --force
  jbrowse add-track $i --load copy --out jb2web_optim --trackId $i --force
done;

## copy files to igv and @jbrowse/react-linear-genome-view demos
for i in volvox.fa volvox-sorted volvox-wgsim badread.1000x badread.50x volvox-sorted; do
  for j in {jb2lgv,igvjs}; do
    echo $i $j
    cp $i* $j/build
  done;
done;

