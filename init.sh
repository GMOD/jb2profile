#!/bin/bash
set -e
rm -rf jb2web
jbrowse create --tag v1.6.5 jb2web
yarn workspaces run build
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.bam.bai
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram
wget -N https://s3.amazonaws.com/jbrowse.org/genomes/volvox/volvox-wgsim.cram.crai

## setup jb2web
jbrowse add-assembly --load copy jb2web/test_data/volvox/volvox.fa --out jb2web --force
jbrowse add-track volvox-wgsim.bam --load copy --out jb2web --trackId volvox-wgsim.bam --force
jbrowse add-track volvox-wgsim.cram --load copy --out jb2web --trackId volvox-wgsim.cram --force
jbrowse add-track jb2web/test_data/volvox/volvox-sorted.bam --load copy --out jb2web --trackId volvox-sorted.bam --force
jbrowse add-track jb2web/test_data/volvox/volvox-sorted.cram --load copy --out jb2web --trackId volvox-sorted.cram --force

## setup jb2web_optim
jbrowse add-assembly --load copy jb2web_optim/test_data/volvox/volvox.fa --out jb2web_optim --force
jbrowse add-track volvox-wgsim.bam --load copy --out jb2web_optim --trackId volvox-wgsim.bam --force
jbrowse add-track volvox-wgsim.cram --load copy --out jb2web_optim --trackId volvox-wgsim.cram --force
jbrowse add-track jb2web_optim/test_data/volvox/volvox-sorted.bam --load copy --out jb2web_optim --trackId volvox-sorted.bam --force
jbrowse add-track jb2web_optim/test_data/volvox/volvox-sorted.cram --load copy --out jb2web_optim --trackId volvox-sorted.cram --force

## copy files to igv and @jbrowse/react-linear-genome-view demos
cp volvox-wgsim.bam jb2lgv/build
cp volvox-wgsim.bam.bai jb2lgv/build
cp volvox-wgsim.cram jb2lgv/build
cp volvox-wgsim.cram.crai jb2lgv/build
cp volvox-wgsim.bam igvjs/build
cp volvox-wgsim.bam.bai igvjs/build
cp volvox-wgsim.cram igvjs/build
cp volvox-wgsim.cram.crai igvjs/build
