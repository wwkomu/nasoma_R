library(tidyverse)
library(gifski)
library(av)
library(gganimate)

#t_diff <- read_csv("data/GLB.Ts+dSST.csv")

data_homo <- read_csv("data/temp_data.csv")

temp_lines <- tibble(
  x = 1,
  y = c(1, 0, -1),
  labels = c("+1\u00B0 C","0\u00B0 C", "-1\u00B0 C")
)

month_labels <- tibble(
  x = 1:12,
  labels = toupper(month.abb),
  y = 1.5
)

annotation <- data_homo %>%
  slice_max(year) %>% 
  slice_max(month_number)

gridlines <- tibble(
  x = c(1.2, 1.3, 1.6),
  xend = c(12.9, 12.8, 12.4),
  y=c(1, 0, -1),
  yend = y
)                                                                               # Set up for geom_seg

plot_tt<- "Global temparature change (1880-2022)"

p_anim <- data_homo %>% ggplot(aes(month_number, t_diff, group = year, color = t_diff)) +
#  geom_rect(aes(xmin=1, xmax=13, ymin=-2, ymax=2.4),
#            color = "black", fill="black",
#            inherit.aes = FALSE) +
  geom_label(aes(x = 1, y = -1.7, label = year),
             fill="black",
            #label.padding=unit(50, "pt"),
             label.size = 0, size = 6) + # Display the current year center!
  geom_line() +
  geom_segment(data = gridlines, aes(x=x, y = y, xend = xend, yend = yend), 
               color = c("yellow", "green","yellow"), # Allows us a background less layer for grids
               inherit.aes = FALSE) +
  geom_text(data = temp_lines, aes(x = x, y = y, label = labels),size = 2,
            color = c("yellow", "green","yellow"),fontface = "bold",
            inherit.aes = FALSE) +                                # Set the temp labels 
  geom_text(data = month_labels, aes(x = x, y = y, label = labels),
    inherit.aes = FALSE, color = "yellow"
#  ,
# angle = seq(360 - 360 / 12, 0, length.out = 12)
  ) +
  #scale_x_continuous(breaks = 1:12,
  #                   labels = month.abb, expand = c(0, 0),
  #                   sec.axis = dup_axis(name = NULL, labels = NULL))+ # Set labels for months; To figure out about the uncommented lines
scale_y_continuous(
  limits = c(-2.0, 1.5), expand = c(0, -0.3)) +                          # Set limits (zoom in or out the y-)
scale_color_gradient2(low="blue", high="red", mid="white",midpoint=0, 
                      guide = "none") +
coord_polar(start = 0)+
labs(x = NULL, y = NULL) +
ggtitle(plot_tt) +
theme(
    panel.background = element_rect(fill = "#000000"),
    plot.background = element_rect(fill = "#000000", color = "#000000"),
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.title = element_blank())+
transition_manual(frames=year, cumulative = TRUE)
  
# Save as .png to allow us view the plot with our settings in real time! 

ggsave("figures/raw/climate_spiral_.png_nasa", width = 4.155, height = 4.5, unit = "in", dpi = 300)

# Animate and save .gif

animate(p_anim,width = 4.155, height = 4.5, unit = "in", res = 300)

anim_save("figures/raw/climate_spiral_animated_nasa.gif")


# To display only the static plot

p_anim




## Assign custom fps
        # nframes = 100, nrow(data_homo),
        # fps = nrow/12/12/60))
        
# anim_save("figures/raw/climate_spiral_animated.gif")
        #
        # # Save as MP4
        # #
        # animate(anim, width = 4.155, height = 4.5, unit = "in", res = 300,
        #         # nframes = 100, nrow(data_homo),
        #         # fps = nrow/12/12/60,
        #         renderer = av_renderer("figures/climate_spiral_animated.mp4")
        #         )
        # ggsave("charts/climate_spiral_static_static.png", width = 10, height = 5)













#```{rc }
# This is my Notes
# geom_text has no background while geom_label has one
#  coord_polar set up the alignment of the clock face

#replace viridis with gradient 





##+
  ##transition_manual(frames=year, cumulative = TRUE)

# # Use `animate()` to pass `args` to customize the `output.gif`
#
# # Save as gif
# #
## 


# New Code ----------------------------------------------------------------

print("THIS IS A NEW SECTION AND I JUST LEARNED THIS FEATURE EXIST", quote=FALSE)

