library(ggplot2)


df = read.csv('memory_usage_processed.csv',sep='\t')
df$window <- factor(df$window, levels = c("1kb", "10kb", "19kb"))

print(head(df))

bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]





ggplot(bam_lr, aes(x = coverage, y = memory)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(labels = scales::comma) +
  ggtitle('BAM longread memory usage')

ggsave('img/bam_lr_memory.png',width=13)

ggplot(bam_sr, aes(x = coverage, y = memory)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~ window) + 
  ggtitle('BAM shortread memory usage')

ggsave('img/bam_sr_memory.png',width=13)




ggplot(cram_sr, aes(x = coverage, y = memory)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~ window) +
  ggtitle('CRAM shortread memory usage')

ggsave('img/cram_sr_memory.png',width=13)


ggplot(cram_lr, aes(x = coverage, y = memory)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~ window) +
  ggtitle('CRAM longread memory usage')

ggsave('img/cram_lr_memory.png',width=13)
