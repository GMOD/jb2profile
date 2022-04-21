library(ggplot2)


df = read.csv('runtime_multi_table_processed.csv',sep='\t')
df$coverage = paste0(df$coverage,'x coverage')
df$coverage <- factor(df$coverage, levels = c("20x coverage", "50x coverage", "100x coverage","150x coverage"))
print(head(df))
df = df[df$time < 600,]
bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]
print(head(bam_lr))




ggplot(bam_lr, aes(x = num_tracks, y = time,group=program,color=program)) + 
  geom_line() +
  facet_grid(~ coverage) +
  ggtitle('BAM longread runtime, rendering multiple tracks')

ggsave('img/bam_lr_multi.png',width=13)


ggplot(bam_sr, aes(x = num_tracks, y = time,group=program,color=program)) + 
  geom_line() +
  facet_grid(~ coverage) +
  ggtitle('BAM shortread runtime, rendering multiple tracks')

ggsave('img/bam_sr_multi.png',width=13)

ggplot(cram_lr, aes(x = num_tracks, y = time,group=program,color=program)) + 
  geom_line() +
  facet_grid(~ coverage) +
  ggtitle('BAM longread runtime, rendering multiple tracks')

ggsave('img/cram_lr_multi.png',width=13)

ggplot(cram_sr, aes(x = num_tracks, y = time,group=program,color=program)) + 
  geom_line() +
  facet_grid(~ coverage) +
  ggtitle('CRAM shortread runtimes, rendering multiple tracks')

ggsave('img/cram_sr_multi.png',width=13)
