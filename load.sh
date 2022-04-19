#!/bin/bash

for l in jb2_174 jb2_noserialize; do
  jbrowse add-assembly --load copy hg19mod.fa --out $l --force --name hg19mod


  for k in longread shortread; do
    for i in 10x 100x 1000x 2000x 3000x 4000x 5000x; do
      for j in bam cram; do
        echo $i $j
        jbrowse add-track $i.$k.$j --load symlink --out $l --trackId $i.$k.$j --force -a hg19mod
      done;
    done;
  done;
done;


for j in {jb2lgv,igvjs}; do
  for k in longread shortread; do
    for i in 10x 100x 1000x 2000x 3000x 4000x 5000x; do
      echo $i $j
      ln -s -f ../../$i.$k.cram $j/build/
      ln -s -f ../../$i.$k.cram.crai $j/build/
      ln -s -f ../../$i.$k.bam $j/build/
      ln -s -f ../../$i.$k.bam.bai $j/build/
    done;
  done;
done;


cp hg19mod.fa* igvjs/build
cp hg19mod.fa* jb2lgv/build

