library(ggplot2)


df = read.csv('runtime_multi_table_processed.csv',sep='\t')

print(head(df))
df = df[df$time < 600,]
bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]
print(head(bam_lr))




ggplot(bam_lr, aes(x = program, y = time)) + 
  geom_bar(stat="identity") +
  facet_grid(~ coverage) +
  ggtitle('BAM 5 tracks - longread runtimes')

ggsave('img/bam_lr_multi.png',width=13)

# ggplot(bam_sr, aes(x = program, y = time)) + 
#   geom_bar(stat="identity") +
#   facet_grid(~ coverage) +
#   ggtitle('BAM 5 tracks - shortread runtimes')

# ggsave('img/bam_sr_multi.png',width=13)




# ggplot(cram_sr, aes(x = program, y = time)) + 
#   geom_bar(stat="identity") +
#   facet_grid(~ coverage) +
#   ggtitle('CRAM 5 tracks - shortread runtimes')

# ggsave('img/cram_sr_multi.png',width=13)


ggplot(cram_lr, aes(x = program, y = time)) + 
  geom_bar(stat="identity") +
  facet_grid(~ coverage) +
  ggtitle('CRAM 5 tracks - longread runtimes')

ggsave('img/cram_lr_multi.png',width=13)
