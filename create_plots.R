library(ggplot2)


df = read.csv('result_bam.txt',sep='\t')

print(head(df))


ggplot(df, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  facet_grid(~ window) + 
  ggtitle('BAM shortread runtimes')

ggsave('img/bam.png',width=13)


df = read.csv('result_cram.txt',sep='\t')

print(head(df))


ggplot(df, aes(x = coverage, y = time)) + 
  geom_line(aes(color = program)) +
  scale_x_continuous(trans='log2') +
  facet_grid(~ window) +
  ggtitle('CRAM shortread runtimes')

ggsave('img/cram.png',width=13)
