
## plot_fps
## if we like facet_grid, this can generate a single image but looks a little messier
# ggplot(df, aes(x = program, y = time_between_frames)) + 
#   geom_jitter(aes(color = program),size=0.8) +
#   labs(y= "time between frames (s)") +
#   facet_grid(vars(read_type,file_type),vars(coverage),scale="free") +
#   ggtitle('Main thread stall')
# ggsave('img/img3_average_fps.png', width = 13)


## plot_runtime
## if we like facet_grid, this can generate a single image but looks a little messier
# ggplot(df, aes(x = coverage, y = time)) + 
#     geom_line(aes(color = program)) +
#     geom_point(aes(color = program)) + 
#     geom_errorbar(aes(ymin=time-sd, ymax=time+sd), width=10) +
#     facet_grid(vars(read_type),vars(file_type),scales="free") +
#     labs(y= "time (s)")+
#     ggtitle('Runtimes - rendering a single track')
# ggsave('img/img2.png', width = 13)



## plot_multi_runtime
## if we like facet_grid, this can generate a single image but looks a little messier
# ggplot(df, aes(x = num_tracks, y = time)) + 
#     geom_line(aes(color = program)) +
#     geom_point(aes(color = program)) + 
#     geom_errorbar(aes(ymin=time-sd, ymax=time+sd), width=10) +
#     facet_grid(vars(read_type,file_type), vars(coverage), scales="free") +
#     xlim(c(1,5)) +
#     labs(y= "time (s)") +
#     ggtitle('Runtimes - rendering multiple tracks')
# ggsave('img/img1.png', width = 13,height=13)
