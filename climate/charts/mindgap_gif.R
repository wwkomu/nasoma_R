library(tidyverse)
library(ggplot2)
# install.packages("gapminder")
library(gapminder)
library(ggplot2)
library(gganimate)
options(browser = "firefox")

data(gapminder)
p <- ggplot(
    gapminder,
    aes(x = gdpPercap, y = lifeExp, size = pop, colour = country)
) +
    geom_point(show.legend = FALSE, alpha = 0.7) +
    scale_color_viridis_d() +
    scale_size(range = c(2, 12)) +
    scale_x_log10() +
    labs(x = "GDP per capita", y = "Life expectancy")
p + transition_time(year)

file_renderer(dir = ".", prefix = "gganim_plot", overwrite = FALSE)
