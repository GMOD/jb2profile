library(ggplot2)
library(patchwork)


total <- read.csv("runtime_table_processed.csv", sep = "\t")
dfs <- split(total, total$window)
nlist <- names(dfs)



plot <- function(df, title) {
  ggplot(df, aes(x = coverage, y = time)) +
    geom_line(aes(color = program)) +
    geom_point(aes(color = program)) +
    geom_errorbar(aes(ymin = time - sd, ymax = time + sd), width = 10) +
    labs(y = "time (s)") +
    ggtitle(title)
}

ggsave2<-function(file,plot,width,height) {
  ggsave(paste0(file,".png"),  plot, width = 16, height = 10)
  ggsave(paste0(file,".pdf"),  plot, width = 16, height = 10)
}

for (i in 1:length(dfs)) {
  df <- dfs[[i]]
  name <- nlist[i]
  bam <- df[df$file_type == "bam", ]
  bam_sr <- bam[bam$read_type == "shortread", ]
  bam_lr <- bam[bam$read_type == "longread", ]
  cram <- df[df$file_type == "cram", ]
  cram_sr <- cram[cram$read_type == "shortread", ]
  cram_lr <- cram[cram$read_type == "longread", ]

  ggsave2(paste0("img/single_track_", name),
    (plot(cram_sr, paste0("CRAM shortread runtime - rendering single track - viewing ",name, " region")) + 
     plot(cram_lr, paste0("CRAM longread runtime - rendering single track - viewing ",name, " region"))) /
      (plot(bam_sr, paste0("BAM shortread runtime - rendering single track - viewing ",name, " region")) + 
       plot(bam_lr, paste0("BAM longread runtime - rendering single track - viewing ",name, " region"))),
    width = 13
  )
}
