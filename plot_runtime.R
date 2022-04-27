library(ggplot2)


df = read.csv('runtime_table_processed.csv',sep='\t')

df = df[df$time < 600,]
bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]



ggplot(bam_lr, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  labs(y= "time (s)")+
  ggtitle('BAM longread runtimes')

ggsave('img/bam_lr.png',height=3)

ggplot(bam_sr, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  labs(y= "time (s)")+
  ggtitle('BAM shortread runtimes')

ggsave('img/bam_sr.png',height=3)




ggplot(cram_sr, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  labs(y= "time (s)")+
  ggtitle('CRAM shortread runtimes')

ggsave('img/cram_sr.png',height=3)


ggplot(cram_lr, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  labs(y= "time (s)")+
  ggtitle('CRAM longread runtimes')

ggsave('img/cram_lr.png',height=3)
