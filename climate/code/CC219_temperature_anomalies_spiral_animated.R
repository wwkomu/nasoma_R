# CLEAN TO RUN WITH r

library(ggplot2)
library(tidyverse)
library(glue)
library(lubridate)
library(gganimate)

t_diff <- read_csv("/home/iamlnx/Documents/GitHub/nasoma_R/climate/data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>%
  select(year = Year, month.abb) %>%
  pivot_longer(-year, names_to = "month", values_to = "t_diff") %>%
  mutate(month = factor(month, levels = month.abb))

# last_Dec

last_dec <- t_diff %>%
  filter(month == "Dec") %>%
  mutate(year = year + 1, month = "last_Dec")

# # next_Jan

next_jan <- t_diff %>%
  filter(month == "Jan") %>%
  mutate(year = year - 1, month = "next_Jan")

# Join/bind the three dfs
## Then pipe the joint_df into ggplot

this_year <- year(today()) - 1

step_index <- data.frame(step_num = c(1:1858))

t_data <- bind_rows(t_diff, next_jan) %>%
  mutate(
    month = factor(month, levels = c(month.abb, "next_Jan")),
    month_number = as.numeric(month),
  ) %>%
  filter(year != 1879) %>%
  arrange(year, month) %>%
  mutate(step_numb = "NA")

t_data$step_numb[which(t_data$step_numb == "NA")] <- as.numeric(1:1858)

annotation <- t_data %>%
  slice_max(year) %>% # Return to year because we got rid of the last_Dec
  slice_max(month_number)

temp_lines <- tibble(
  x = 12,
  y = c(1.5, 2.0),
  labels = c("1.5\u00B0C", "2.0\u00B0C")
)

month_labels <- tibble(
  x = 1:12,
  labels = month.abb,
  y = 2.7
)

p_data <- read_csv("data/t_data.csv")

p_data %>%
  ggplot(aes(month_number, t_diff, group = year, color = year)) +
  geom_col(data = month_labels, aes(x = x + .5, y = 2.4), fill = "black", width = 1, inherit.aes = FALSE) +
  geom_col(data = month_labels, aes(x = x + .5, y = -2), fill = "black", width = 1, inherit.aes = FALSE) +
  geom_hline(yintercept = c(1.5, 2.0), color = "red") +
  geom_point(
    data = annotation, aes(
      x = month_number, y = t_diff,
      color = year
    ),
    size = 5,
    inherit.aes = FALSE
  ) +
  geom_label(
    data = temp_lines, aes(
      x = x, y = y,
      label = labels
    ),
    color = "red", fill = "black",
    label.size = 0,
    inherit.aes = FALSE
  ) +
  geom_text(
    data = month_labels,
    aes(
      x = x,
      y = y,
      label = labels
    ),
    inherit.aes = FALSE,
    color = "white",
    angle = seq(360 - 360 / 12, 0, length.out = 12),
  ) +
  geom_line() +
  geom_text(aes(x = 1, y = -1.3, label = "2022")) +
  scale_x_continuous(
    breaks = 1:12,
    labels = month.abb, expand = c(0, 0),
    sec.axis = dup_axis(name = NULL, labels = NULL)
  ) +
  scale_y_continuous(
    breaks = seq(-2, 2, 0.2),
    limits = c(-2, 2.7), expand = c(0, -0.7),
    sec.axis = dup_axis(name = NULL, labels = NULL)
  ) +
  scale_color_viridis_c(
    breaks = seq(1880, 2022, 20),
    guide = "none"
  ) +
  scale_size_manual(
    breaks = c(FALSE, TRUE),
    values = c(0.25, 1),
    guide = "none"
  ) +
  coord_polar(start = 2 * pi / 12) +
  # coord_cartesian(xlim = c(1, 12)) +
  labs(x = NULL, y = NULL) +
  # ggtitle(label = glue("Global temparature change since {min_year} by month")) +
  # ggtitle(plot_tt) +
  theme(
    panel.background = element_rect(fill = "#444444", size = 1),
    plot.background = element_rect(fill = "#444444", color = "#444444"),
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_text(color = "white", size = 13),
    plot.title = element_text(color = "white", hjust = 0.5, size = 15),
  ) +
  transition_reveal(along = step_number)

ggsave("this_is_smelling_rat.png")

write
write_csv(t_data, file = "temp_data.csv")


tt_data %>%
  ggplot(aes(month_number, t_diff, group = year, color = year)) +
  # geom_col(data = month_labels, aes(x = x + .5, y = 2.4), fill = "black", width = 1, inherit.aes = FALSE) +
  # geom_col(data = month_labels, aes(x = x + .5, y = -2), fill = "black", width = 1,
  #          inherit.aes = FALSE) +
  # geom_hline(yintercept = c(1.5, 2.0), color = "red") +
  # geom_point(
  #   data = annotation, aes(
  #     x = month_number, y = t_diff,
  #     color = year
  #   ),
  #   size = 5,
  #   inherit.aes = FALSE
  # ) +
  # geom_label(
  #   data = temp_lines, aes(
  #     x = x, y = y,
  #     label = labels
  #   ),
  #   color = "red", fill = "black",
  #   label.size = 0,
  #   inherit.aes = FALSE
  # ) +
  # geom_text(
  #   data = month_labels,
  #   aes(
  #     x = x,
  #     y = y,
  #     label = labels
  #   ),
  #   inherit.aes = FALSE,
  #   color = "white",
  #   angle = seq(360 - 360 / 12, 0, length.out = 12),
  # )+
  geom_line() +
  geom_text(aes(x = 1, y = -1.3, label = year)) +
  scale_x_continuous(
    breaks = 1:12,
    labels = month.abb, expand = c(0, 0),
    sec.axis = dup_axis(name = NULL, labels = NULL)
  ) +
  scale_y_continuous(
    breaks = seq(-2, 2, 0.2),
    limits = c(-2, 2.7), expand = c(0, -0.7),
    sec.axis = dup_axis(name = NULL, labels = NULL)
  ) +
  scale_color_viridis_c(
    breaks = seq(1880, 2022, 20),
    guide = "none"
  ) +
  # scale_size_manual(
  #   breaks = c(FALSE, TRUE),
  #   values = c(0.25, 1),
  #   guide = "none"
  # ) +
  coord_polar(start = 2 * pi / 12) +
  theme(
    panel.background = element_rect(fill = "#444444", size = 1),
    plot.background = element_rect(fill = "#444444", color = "#444444"),
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_text(color = "white", size = 13),
    plot.title = element_text(color = "white", hjust = 0.5, size = 15),
  ) +
  transition_manual(along = step_num)


data_homo <- read_csv("data/temp_data.csv")

tail(data)
