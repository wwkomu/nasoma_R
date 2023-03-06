library(maps)
library(tidyverse)

world_map <- map_data("world")

head(world_map)

ggplot(data = world_map, aes(long, lat, map_id = region)) +
    geom_map(map = world_map, fill = NA, color = "white") +
    coord_fixed() +
    theme(
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black")
    )

ggsave("figures/world_map_test.png")

 

head(world_map)

ggplot(data = world_map, aes(long, lat, map_id = region)) +
    geom_map(map = world_map, fill = NA, color = "white") +
    coord_fixed() +
    theme(
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black")
    )

ggsave("figures/world_map_test.png")
