library(ggplot2)
library(patchwork)


total = read.csv('runtime_table_processed.csv',sep='\t')
dfs = split(total, total$window)
nlist = names(dfs)



plot <- function(df, title) {
  ggplot(df, aes(x = coverage, y = time)) + 
    geom_line(aes(color = program)) +
    geom_point(aes(color = program)) + 
    geom_errorbar(aes(ymin=time-sd, ymax=time+sd), width=10) +
    labs(y= "time (s)")+
    ggtitle(title)
}


for(i in 1:length(dfs)) {
  df = dfs[[i]]
  name = nlist[i]
  bam = df[df$file_type=='bam',]
  bam_sr = bam[bam$read_type=='shortread',]
  bam_lr = bam[bam$read_type=='longread',]
  cram = df[df$file_type=='cram',]
  cram_sr = cram[cram$read_type=='shortread',]
  cram_lr = cram[cram$read_type=='longread',]

  ggsave(paste0('img/single_track_',name,'.png'), 
         (plot(cram_sr, "CRAM shortread")+plot(cram_lr, "CRAM longread")) /
         (plot(bam_sr, "BAM shortread")+plot(bam_lr, "BAM longread")) +
          plot_annotation(
            title = paste0('Time to render single track on ',name,' region'),
            theme = theme(plot.title = element_text(size = 16))
          )
       , width=13)
}
