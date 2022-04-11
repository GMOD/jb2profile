#!/bin/bash

for j in jb2_165 jb2_167 jb2_169 jb2_main jb2_noserialize; do
  jbrowse add-assembly --load copy volvox.fa --out $j --force
  for i in 28x 56x 112x 224x 448x 896x 1792x; do
    echo $i $j
    jbrowse add-track $i.shortread.cram --load symlink --out $j --trackId $i.shortread.cram --force -a volvox
    jbrowse add-track $i.shortread.bam --load symlink --out $j --trackId $i.shortread.bam --force -a volvox
  done;
  for i in 40x 80x 160x 320x 640x 1280x; do
    echo $i $j
    jbrowse add-track $i.longread.cram --load symlink --out $j --trackId $i.longread.cram --force -a volvox
    jbrowse add-track $i.longread.bam --load symlink --out $j --trackId $i.longread.bam --force -a volvox
  done;
done;

## copy files to igv and @jbrowse/react-linear-genome-view demos
for i in 28x 56x 112x 224x 448x 896x 1792x; do
  for j in {jb2lgv,igvjs}; do
    ln -s -f ../../$i.shortread.cram $j/build/
    ln -s -f ../../$i.shortread.cram.crai $j/build/
    ln -s -f ../../$i.shortread.bam $j/build/
    ln -s -f ../../$i.shortread.bam.bai $j/build/
  done;
done;
for i in 40x 80x 160x 320x 640x 1280x; do
  for j in {jb2lgv,igvjs}; do
    ln -s -f ../../$i.longread.cram $j/build/
    ln -s -f ../../$i.longread.cram.crai $j/build/
    ln -s -f ../../$i.longread.bam $j/build/
    ln -s -f ../../$i.longread.bam.bai $j/build/
  done;
done;

cp volvox.fa* igvjs/build
cp volvox.fa* jb2lgv/build

