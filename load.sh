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


  for s in longread shortread; do
    for i in {1..5}; do
      for j in 02 05 10 15; do
        for f in bam cram; do
          k=0.$j;
          a=$(echo  "1000*$k/1"|bc );
          track=multi$i."$a"x.$s.$f
          echo $i $j $a $track
          jbrowse add-track $track --load symlink --out $l --trackId $track --force -a hg19mod
        done;
      done;
    done;
  done;
done;



for j in {jb2lgv,igvjs}; do
  for i in *.cram* *.bam*; do
    ln -s -f ../../$i $j/build/
  done;
done;

cp hg19mod.fa* igvjs/build
cp hg19mod.fa* jb2lgv/build

