library(ggplot2)


df = read.csv('runtime_table_processed.csv',sep='\t')
print(head(df))

df = df[df$time < 300,]
bam = df[df$file_type=='bam',]
bam_sr = bam[bam$read_type=='shortread',]
bam_lr = bam[bam$read_type=='longread',]
cram = df[df$file_type=='cram',]
cram_sr = cram[cram$read_type=='shortread',]
cram_lr = cram[cram$read_type=='longread',]
print(head(df))


plot <- function(df, filename, title) {
  ggplot(df, aes(x = coverage, y = time)) + 
    geom_line(aes(color = program)) +
    geom_point(aes(color = program)) + 
    geom_errorbar(aes(ymin=time-sd, ymax=time+sd), width=10) +
    labs(y= "time (s)")+
    ggtitle(title)

  ggsave(filename, height = 3)
}

plot(cram_lr, 'img/cram_lr.png', 'CRAM longread runtimes')
plot(cram_sr, 'img/cram_sr.png', 'CRAM shortread runtimes')
plot(bam_lr, 'img/bam_lr.png', 'BAM longread runtimes')
plot(bam_sr, 'img/bam_sr.png', 'BAM shortread runtimes')


## if we like facet_grid...
ggplot(df, aes(x = coverage, y = time)) + 
    geom_line(aes(color = program)) +
    geom_point(aes(color = program)) + 
    geom_errorbar(aes(ymin=time-sd, ymax=time+sd), width=10) +
    facet_grid(vars(read_type),vars(file_type),scales="free") +
    labs(y= "time (s)")+
    ggtitle('Runtimes')

ggsave('img/img2.png', width = 13)
