library(ggplot2)


df = read.csv('runtime_multi_table_processed.csv',sep='\t')
df$coverage = paste0(df$coverage,'x coverage')
df$coverage <- factor(df$coverage, levels = c("20x coverage", "50x coverage", "100x coverage","150x coverage"))
df = df[df$time < 300,]
bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]


plot<-function(df, title,filename) {
  ggplot(df, aes(x = num_tracks, y = time, group=program, color=program)) + 
    geom_line() +
    labs(y= "time (s)")+
    facet_wrap(~ coverage, scales = "free_y", ncol=4) +
    ggtitle(title)

  ggsave(filename, width=13, height=3)
}

plot(bam_lr, 'BAM longread runtime - rendering multiple tracks', 'img/bam_lr_multi.png')
plot(bam_sr, 'BAM shortread runtime - rendering multiple tracks', 'img/bam_sr_multi.png')
plot(cram_lr, 'CRAM longread runtime - rendering multiple tracks', 'img/cram_lr_multi.png')
plot(cram_sr, 'CRAM shortread runtime - rendering multiple tracks', 'img/cram_sr_multi.png')

