library(ggplot2)

df = read.csv('fps_table_processed.csv',sep='\t')
df=df[df$window=="19kb",]
df$time_between_frames = 1/df$average_fps

print(head(df))

bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]






ggplot(bam_lr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  facet_grid(~ coverage) +
  ggtitle('BAM longread main thread stall')

ggsave('img/bam_lr_average_fps.png',width=20)

ggplot(bam_sr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  facet_grid(~ coverage) +
  ggtitle('BAM shortread main thread stall')

ggsave('img/bam_sr_average_fps.png',width=20)



ggplot(cram_sr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  facet_grid(~ coverage) +
  ggtitle('CRAM shortread main thread stall')

ggsave('img/cram_sr_average_fps.png',width=20)




ggplot(cram_lr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  facet_grid(~ coverage) +
  ggtitle('CRAM longread main thread stall')

ggsave('img/cram_lr_average_fps.png',width=20)



