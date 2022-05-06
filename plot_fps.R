library(ggplot2)

# df has raw values
df = read.csv('fps_table_processed.csv',sep='\t')
df$time_between_frames = 1/df$average_fps
df$coverage = paste0(df$coverage,'x coverage')
df$coverage <- factor(df$coverage, levels = c("20x coverage", "200x coverage", "400x coverage","600x coverage", "800x coverage", "1000x coverage"))
# df2 has expected wait time and variance
df2 = read.csv('fps_table_processed2.csv',sep='\t')
df2$upper=qgamma(0.95,df2$alpha,df2$beta)
df2$lower=qgamma(0.05,df2$alpha,df2$beta)
print(head(df2))



bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]



bam2 = df2[df2$file_type=='bam',]
bam_sr2 = bam2[bam2$read_type=='shortread',]
bam_lr2 = bam2[bam2$read_type=='longread',]
cram2 = df2[df2$file_type=='cram',]
cram_sr2 = cram2[cram2$read_type=='shortread',]
cram_lr2 = cram2[cram2$read_type=='longread',]




plot <- function(df, filename, title) {
  ggplot(df, aes(x = program, y = time_between_frames)) + 
    geom_jitter(aes(color = program)) +
    labs(y= "time between frames (s)")+
    facet_grid(~ coverage) +
    theme(legend.position = "none") +
    ggtitle(title)

  ggsave(filename, height = 3,width=15)
}

plot_cumsums <- function(df, filename, title) {

  df$csum <- ave(df$time_between_frames, df$program, df$coverage, FUN=cumsum)
  df$count <- ave(df$time_between_frames, df$program, df$coverage, FUN=seq_along)


  ggplot(df, aes(x = csum, y = count)) + 
    geom_line(aes(color = program)) +
    labs(x= "time (s)",y="frame #") +
    facet_grid(~ coverage, scale="free") +
    ggtitle(title)

  ggsave(filename, height = 3,width=13)
}

plot_ev <- function(df, filename, title) {
  ggplot(df, aes(x = coverage, y = expected_value)) + 
    geom_line(aes(color = program)) +
    geom_point(aes(color=program),position=position_dodge(width=20)) +
    geom_errorbar(aes(ymin=lower, ymax=upper,color=program), width=10,position=position_dodge(width=20)) +
    labs(y= "time (s)") +
    ggtitle(title)

  ggsave(filename, height = 3)
}

plot(cram_lr, 'img/cram_lr_average_fps.png', 'CRAM longread - main thread stall')
plot(cram_sr, 'img/cram_sr_average_fps.png', 'CRAM shortread - main thread stall')
plot(bam_lr, 'img/bam_lr_average_fps.png', 'BAM longread - main thread stall')
plot(bam_sr, 'img/bam_sr_average_fps.png', 'BAM shortread - main thread stall')


plot_cumsums(cram_lr, 'img/cram_lr_cumsums.png', 'CRAM longread - time vs frame #')
plot_cumsums(cram_sr, 'img/cram_sr_cumsums.png', 'CRAM shortread - time vs frame #')
plot_cumsums(bam_lr, 'img/bam_lr_cumsums.png', 'BAM longread - time vs frame #')
plot_cumsums(bam_sr, 'img/bam_sr_cumsums.png', 'BAM shortread - time vs frame #')



plot_ev(cram_lr2, 'img/cram_lr_ev.png', 'CRAM longread - expected wait time')
plot_ev(cram_sr2, 'img/cram_sr_ev.png', 'CRAM shortread - expected wait time')
plot_ev(bam_lr2, 'img/bam_lr_ev.png', 'BAM longread - expected wait time')
plot_ev(bam_sr2, 'img/bam_sr_ev.png', 'BAM shortread - expected wait time')








