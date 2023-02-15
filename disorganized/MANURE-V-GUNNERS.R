# Load packages
library(tidyverse)
library(janitor)
library(lubridate)
library(readr)

gunners_v_manutd <- read.csv("data/arsenal_v_man_u.csv", skip = 2) %>%
    clean_names() %>%
    rename(
        arsenal = arsenal_f_c_kenya,
        manutd = manchester_united_f_c_kenya,
        date = week
    )

# Separate
#
# Arsenal
gunners <- gunners_v_manutd %>%
    select(date, arsenal) %>%
    mutate(club = "Arsenal") %>%
    rename(total_mention = arsenal)

# Man United
#
manutd <- gunners_v_manutd %>%
    select(date, manutd) %>%
    mutate(club = "Man Utd") %>%
    rename(total_mention = manutd)


# Combine
#
gunners_v_manutd_df <- rbind(gunners, manutd) %>%
    filter(date >= "2022-02-20")

head(gunners_v_manutd_df)

# Graph different data
guns_manutd_line_plot <- ggplot(data = gunners_v_manutd_df, aes(color = club, group = club)) +
    geom_line(aes(x = date, y = total_mention)) +
    # scale_x_continuous(breaks = seq(2022, 2023, 2)) +
    theme_classic()

ggsave("arsenal_v_manutd_pop_kenya.png", plot = guns_manutd_line_plot)
