#!/bin/bash

for l in jb2_174 jb2_noserialize; do
  jbrowse add-assembly --load copy hg19mod.fa --out $l --force --name hg19mod


  for k in longread shortread; do
    for i in 0.02 0.20 0.40 0.60 0.80 1; do
      a=$(echo  "1000*$i/1"|bc )x;
      for j in bam cram; do
        echo $i $j $a
        jbrowse add-track $a.$k.$j --load symlink --out $l --trackId $a.$k.$j --force -a hg19mod
      done;
    done;
  done;
done;


for j in {jb2lgv,igvjs}; do
  for k in longread shortread; do
    for i in 0.02 0.20 0.40 0.60 0.80 1; do
      a=$(echo  "1000*$i/1"|bc )x;
      ln -s -f ../../$a.$k.cram $j/build/
      ln -s -f ../../$a.$k.cram.crai $j/build/
      ln -s -f ../../$a.$k.bam $j/build/
      ln -s -f ../../$a.$k.bam.bai $j/build/
    done;
  done;
done;


cp hg19mod.fa* igvjs/build
cp hg19mod.fa* jb2lgv/build

