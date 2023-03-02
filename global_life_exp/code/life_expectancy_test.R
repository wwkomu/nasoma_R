source("~/Documents/GitHub/nasoma_R/global_health_indicators/code/global_life_exp_data.Rmd")

my_gapminder <- read_csv("/home/iamlnx/Documents/GitHub/nasoma_R/global_health_indicators/data/LifeExp_WorldBank.csv", skip = 4, na = "") %>%
    select(-"Country Code", -"Indicator Name", -"Indicator Code") %>%
    pivot_longer(-"Country Name", names_to = "year", values_to = "life_exp") %>%
    clean_names() %>%
    mutate(
        country = country_name,
        year = as.numeric(as.character(year))
    ) %>%
    group_by(country) %>%
    select(country, year, life_exp) %>%
    drop_na()

# Filter for Kenya
kenya_life_exp <- my_gapminder %>%
    filter(
        country  %in%  c("Kenya")
    ) %>%
    group_by(country)

# Kenya's life expectancy plot
kenya_life_exp %>%
    ggplot(aes(year, life_exp)) +
    geom_line(show.legend = FALSE) +
    geom_point(fill = "white", shape = 18, size = 2, show.legend = FALSE) +
    # shape enables the white fill!
    scale_x_continuous(breaks = seq(1960, 2030, by = 10), expand = c(0, 1)) +
    coord_cartesian(clip = "off") +
    scale_y_continuous(limits = c(45, 70), expand = c(0, 0)) +
    labs(
        title = "Kenya's life expectancy from 1960 to 2020",
        x = "Year",
        y = "Average life expectancy (years)",
        caption = "Data source: World Bank"
    ) +
    theme_clean() +
    theme(
        plot.title = element_text(margin = margin(b = 10)),
        plot.title.position = "plot",
        axis.text = element_text(margin = margin(b = 10))
    ) # +
    # transition_reveal(along = year)

ggsave("figures/kenya_life_exp_1960-2020.png", width = 4.5, height = 4.5, unit = "in")

# Kenya vs. China
#
# Filter for Kenya & China
kenya_china_life_exp <- my_gapminder %>%
    filter(
        country  %in%  c("Kenya", "China")
    ) %>%
    drop_na()


# Kenya's vs. China's life expectancy plot
#
p_ke_china <- kenya_china_life_exp %>%
    ggplot(aes(year, life_exp, group = country, color = country)) +
    geom_line(show.legend = TRUE, linewidth = 1) +
    geom_point(fill = "white", shape = 21, size = 2, show.legend = TRUE) +
    # shape enables the white fill!
    scale_x_continuous(breaks = seq(1960, 2030, by = 10), expand = c(0, 1)) +
    coord_cartesian(clip = "off") +
    scale_y_continuous(limits = c(30, 80), expand = c(0, 0)) +
    labs(
        title = "Kenya's vs China's life expectancy from 1960 to 2020",
        x = "Year",
        y = "Average life expectancy (years)",
        caption = "Data source: World Bank"
    ) +
    theme_classic() +
    theme(
        plot.title = element_text(margin = margin(b = 10), color = "red", face = "bold"),
        plot.title.position = "plot",
        axis.text = element_text(margin = margin(b = 10)),
        legend.title = element_blank()
    )  +
    transition_reveal(along = year)

p_ke_china

ggsave("figures/kenya-china_life_exp_1960-2020_RS.png", width = 4.5, height = 4.5, unit = "in")

animate(p_ke_china, width = 4.5, height = 4.5, unit = "in", res = 300)

anim_save("figures/kenya_v_china_lifeExp_line_animated_world_bank_RS.gif")

