library(tidyverse)
library(janitor)

flavors_df <- read_csv("data/flavors_of_cacao.csv") %>%
    clean_names() %>%
    rename(company = company_maker_if_known)

colnames(flavors_df)



trimmed_flavors_df <- flavors_df



trimmed_flavors_df %>%
    summarise(stdev=sd(rating))

best_trimmed_flavors_df <- trimmed_flavors_df %>%
    filter(cocoa_percent >= 75, rating >= 3.9)


ggplot(data = best_trimmed_flavors_df) +
    geom_bar(aes(x = rating))

ggplot(data = best_trimmed_flavors_df) +
    geom_bar(mapping = aes(x = company_location, fill=rating))

ggplot(data = best_trimmed_flavors_df) +
    geom_bar(mapping = aes(x = company)) +
    facet_wrap(~company)

colnames(best_trimmed_flavors_df)
