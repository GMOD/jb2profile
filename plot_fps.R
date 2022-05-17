library(ggplot2)
library(patchwork)

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




plot <- function(df, title) {
  ggplot(df, aes(x = program, y = time_between_frames)) + 
    geom_jitter(aes(color = program)) +
    labs(y= "time between frames (s)")+
    facet_grid(~ coverage) +
    theme(legend.position = "none") +
    ggtitle(title)

}

plot_cumsums <- function(df, title) {

  df$csum <- ave(df$time_between_frames, df$program, df$coverage, FUN=cumsum)
  df$count <- ave(df$time_between_frames, df$program, df$coverage, FUN=seq_along)


  ggplot(df, aes(x = csum, y = count)) + 
    geom_line(aes(color = program)) +
    labs(x= "time (s)",y="frame #") +
    facet_grid(~ coverage, scale="free") +
    ggtitle(title)

}


plot_lm <- function(df, title) {

  ggplot(df, aes(x = coverage, y = expected_value, color=program)) + 
    geom_point() +
    stat_smooth(method = "lm", aes(color=program,fill=program)) +
    geom_errorbar(aes(ymin=lower, ymax=upper), width=40,position=position_dodge(width=20)) +
    labs(y= "Response time (s)") +
    ggtitle(title)

}


plot_bare <- function(df, title) {

  ggplot(df, aes(x = coverage, y = expected_value, color=program)) + 
    geom_point() +
    stat_smooth(method = "lm", aes(color=program,fill=program),lty=3) +
    geom_errorbar(aes(ymin=lower, ymax=upper), width=40,position=position_dodge(width=20)) +
    labs(y= "Response time (s)") +
    ggtitle(title)

}

plot_superbare <- function(df, title) {

  ggplot(df, aes(x = coverage, y = expected_value, color=program)) + 
    geom_point() +
    stat_smooth(method = "lm", aes(color=program,fill=program),lty=3,se=F) +
    geom_errorbar(aes(ymin=lower, ymax=upper), width=40,position=position_dodge(width=20)) +
    labs(y= "Response time (s)") +
    ggtitle(title)

}


ggsave('img/fps_scatter.png', 
(plot(cram_lr, 'CRAM longread - main thread stall')/
plot(cram_sr, 'CRAM shortread - main thread stall')/
plot(bam_lr, 'BAM longread - main thread stall')/
plot(bam_sr, 'BAM shortread - main thread stall')),width=16,height=16)


ggsave('img/fps_cumsums.png', 
(plot_cumsums(cram_lr, 'CRAM longread - frame # vs time')+
plot_cumsums(cram_sr, 'CRAM shortread - frame # vs time'))/
(plot_cumsums(bam_lr, 'BAM longread - frame # vs time')+
plot_cumsums(bam_sr, 'BAM shortread - frame # vs time')), width=16)




ggsave('img/fps_ev.png', 
(plot_lm(cram_lr2, 'CRAM longread - average response time')+
plot_lm(cram_sr2, 'CRAM shortread - average response time'))/
(plot_lm(bam_lr2, 'BAM longread - average response time')+
plot_lm(bam_sr2, 'BAM shortread - average response time')),width=16)



ggsave('img/fps_bare.png', 
(plot_bare(cram_lr2, 'CRAM longread - average response time')+
plot_bare(cram_sr2, 'CRAM shortread - average response time'))/
(plot_bare(bam_lr2, 'BAM longread - average response time')+
plot_bare(bam_sr2, 'BAM shortread - average response time')),width=16)



ggsave('img/fps_superbare.png', 
(plot_superbare(cram_lr2, 'CRAM longread - average response time')+
plot_superbare(cram_sr2, 'CRAM shortread - average response time'))/
(plot_superbare(bam_lr2, 'BAM longread - average response time')+
plot_superbare(bam_sr2, 'BAM shortread - average response time')),width=16)

