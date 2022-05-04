library(ggplot2)
library(dplyr)

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


plot <- function(df, filename, title) {
  ggplot(bam_lr, aes(x = program, y = time_between_frames)) + 
    geom_jitter(aes(color = program)) +
    labs(y= "time between frames (s)")+
    facet_grid(~ coverage) +
    ggtitle(title)

  ggsave(filename, height = 3)
}

plot_cumsums <- function(df, filename, title) {

  df$csum <- ave(df$time_between_frames, df$program, df$coverage, FUN=cumsum)
  df$count <- ave(df$time_between_frames, df$program, df$coverage, FUN=seq_along)

  # df = df %>%
  #   group_by(program) %>%
  #   mutate(count = n())
  print(head(df))

  ggplot(df, aes(x = count, y = csum)) + 
    geom_line(aes(color = program)) +
    labs(y= "time (s)") +
    facet_grid(~ coverage, scale="free") +
    ggtitle(title)

  ggsave(filename, width=13,height = 3)
}

plot(cram_lr, 'img/cram_lr_average_fps.png', 'CRAM longread main thread stall')
plot(cram_sr, 'img/cram_sr_average_fps.png', 'CRAM shortread main thread stall')
plot(bam_lr, 'img/bam_lr_average_fps.png', 'BAM longread main thread stall')
plot(bam_sr, 'img/bam_sr_average_fps.png', 'BAM shortread main thread stall')


plot_cumsums(cram_lr, 'img/cram_lr_cumsums.png', 'CRAM longread frame # vs time')
plot_cumsums(cram_sr, 'img/cram_sr_cumsums.png', 'CRAM shortread frame # vs time')
plot_cumsums(bam_lr, 'img/bam_lr_cumsums.png', 'BAM longread frame # vs time')
plot_cumsums(bam_sr, 'img/bam_sr_cumsums.png', 'BAM shortread frame # vs time')








## if we like facet_grid, this can generate a single image but looks a little messier
# ggplot(df, aes(x = program, y = time_between_frames)) + 
#   geom_jitter(aes(color = program),size=0.8) +
#   labs(y= "time between frames (s)") +
#   facet_grid(vars(read_type,file_type),vars(coverage),scale="free") +
#   ggtitle('Main thread stall')
# ggsave('img/img3_average_fps.png', width = 13)
