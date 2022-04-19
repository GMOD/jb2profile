#!/bin/bash

for l in jb2_165 jb2_167 jb2_169 jb2_174 jb2_noserialize; do
  jbrowse add-assembly --load copy chr22.mask.fa.gz --out $l --force


  for k in longread shortread; do
    for i in 100x 1000x 2000x 3000x 4000x 5000x; do
      for j in bam cram; do
        echo $i $j
        jbrowse add-track $i.$k.$j --load symlink --out $l --trackId $i.$k.%$j --force -a volvox
      done;
    done;
  done;
done;


for j in {jb2lgv,igvjs}; do
  for k in longread shortread; do
    for i in 100x 1000x 2000x 3000x 4000x 5000x; do
      echo $i $j
      ln -s -f ../../$i.$k.cram $j/build/
      ln -s -f ../../$i.$k.cram.crai $j/build/
      ln -s -f ../../$i.$k.bam $j/build/
      ln -s -f ../../$i.$k.bam.bai $j/build/
    done;
  done;
done;


cp chr22.mask.fa.gz* igvjs/build
cp chr22.mask.fa.gz* jb2lgv/build

