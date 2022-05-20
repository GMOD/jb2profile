library(ggplot2)
library(patchwork)


df <- read.csv("runtime_multi_table_processed.csv", sep = "\t")
df$coverage <- paste0(df$coverage, "x coverage")
df$coverage <- factor(df$coverage, levels = c("20x coverage", "50x coverage", "100x coverage", "150x coverage"))
df <- df[df$time < 300, ]
bam <- df[df$file_type == "bam", ]
bam_sr <- bam[bam$read_type == "shortread", ]
bam_lr <- bam[bam$read_type == "longread", ]
cram <- df[df$file_type == "cram", ]
cram_sr <- cram[cram$read_type == "shortread", ]
cram_lr <- cram[cram$read_type == "longread", ]



ggsave2<-function(file,plot,width,height) {
  ggsave(paste0(file,".png"),  plot, width = 16, height = 10)
  ggsave(paste0(file,".pdf"),  plot, width = 16, height = 10)
}

plot <- function(df, title) {
  ggplot(df, aes(x = num_tracks, y = time)) +
    geom_line(aes(color = program)) +
    geom_point(aes(color = program)) +
    geom_errorbar(aes(ymin = time - sd, ymax = time + sd), width = 0.1) +
    labs(y = "time (s)") +
    facet_grid(~coverage) +
    ggtitle(title)
}

ggsave2("img/multi",
  (plot(bam_lr, "BAM longread runtime - rendering multiple tracks - viewing 5kb region") /
    plot(bam_sr, "BAM shortread runtime - rendering multiple tracks - viewing 5kb region") /
    plot(cram_lr, "CRAM longread runtime - rendering multiple tracks - viewing 5kb region") /
    plot(cram_sr, "CRAM shortread runtime - rendering multiple tracks - viewing 5kb region")),
  width = 13, height = 11
)
