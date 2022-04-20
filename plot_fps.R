library(ggplot2)
library(ggbeeswarm)

df = read.csv('fps_table_processed.csv',sep='\t')
df=df[df$window=="19kb",]
df=df[df$coverage==800,]
df$time_between_frames = 1/df$average_fps

print(head(df))

bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]






ggplot(bam_lr, aes(x = program, y = time_between_frames)) + 
  geom_quasirandom(aes(color = program)) +
  scale_y_continuous(labels = scales::comma) +
  ggtitle('BAM shortread average FPS (800x)')

ggsave('img/bam_lr_average_fps.png',width=13)

ggplot(bam_sr, aes(x = program, y = time_between_frames)) + 
  geom_quasirandom(aes(color = program)) +
  scale_y_continuous(labels = scales::comma) +
  ggtitle('BAM shortread average FPS (800x)')

ggsave('img/bam_sr_average_fps.png',width=13)



ggplot(cram_sr, aes(x = program, y = time_between_frames)) + 
  geom_quasirandom(aes(color = program)) +
  scale_y_continuous(labels = scales::comma) +
  ggtitle('CRAM shortread average FPS (800x)')

ggsave('img/cram_sr_average_fps.png',width=13)




ggplot(cram_lr, aes(x = program, y = time_between_frames)) + 
  geom_quasirandom(aes(color = program)) +
  scale_y_continuous(labels = scales::comma) +
  ggtitle('CRAM longread average FPS (800x)')

ggsave('img/cram_lr_average_fps.png',width=13)



