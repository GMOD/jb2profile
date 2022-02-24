#!/bin/bash
set -e
rm -rf jb2web
jbrowse create --tag v1.6.5 jb2web
yarn workspaces run build
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam.bai
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram.crai
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.1000x.cram.crai
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram
wget -N -q https://s3.amazonaws.com/jbrowse.org/genomes/volvox/badread.50x.cram.crai

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
for i in volvox.fa volvox.fa.fai volvox-sorted.{bam,cram} volvox-wgsim.{bam,cram} badread.1000x.{bam,cram} badread.50x.{bam,cram} volvox-sorted.{bam,cram}; do
  for j in jb2lgv igvjs; do
    echo $i $j
    cp $i $j/build
    cp $i.bai $j/build 2>>/dev/null
    cp $i.crai $j/build 2>>/dev/null
  done;
done;

