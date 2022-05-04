library(ggplot2)

df = read.csv('fps_table_processed.csv',sep='\t')
df$time_between_frames = 1/df$average_fps
df$coverage = paste0(df$coverage,'x coverage')
df$coverage <- factor(df$coverage, levels = c("20x coverage", "200x coverage", "400x coverage","600x coverage", "800x coverage", "1000x coverage"))

# print(head(df))

bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]






ggplot(bam_lr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  labs(y= "time between frames (s)")+
  facet_grid(~ coverage) +
  ggtitle('BAM longread main thread stall')

ggsave('img/bam_lr_average_fps.png',width=13,height=3)

ggplot(bam_sr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  labs(y= "time between frames (s)")+
  facet_grid(~ coverage) +
  ggtitle('BAM shortread main thread stall')

ggsave('img/bam_sr_average_fps.png',width=13,height=3)



ggplot(cram_sr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  labs(y= "time between frames (s)")+
  facet_grid(~ coverage) +
  ggtitle('CRAM shortread main thread stall')

ggsave('img/cram_sr_average_fps.png',width=13,height=3)




ggplot(cram_lr, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program)) +
  labs(y= "time between frames (s)")+
  facet_grid(~ coverage) +
  ggtitle('CRAM longread main thread stall')

ggsave('img/cram_lr_average_fps.png',width=13,height=3)



## if we like facet_grid...
ggplot(df, aes(x = program, y = time_between_frames)) + 
  geom_jitter(aes(color = program),size=0.8) +
  labs(y= "time between frames (s)") +
  facet_grid(vars(read_type,file_type),vars(coverage),scale="free") +
  ggtitle('Main thread stall')


ggsave('img/img3.png', width = 13)
