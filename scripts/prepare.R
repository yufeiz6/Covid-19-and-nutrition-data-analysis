# Import packages
library(stringr)
library(ggplot2)
library(leaflet)
library(knitr)
library(dplyr)
library(maps)
library(mapproj)
library(tidyr)
library(forcats)

# A function used to prepare data for the report
prepare <- function(covid_19_ds_ori, country_prof) {
  covid_19_ds_ori <- covid_19_ds_ori %>%
    rename(country = Country)

  country_prof <- country_prof %>%
    select(country, Region)

  covid_19 <- covid_19_ds_ori %>%
    left_join(country_prof, by = "country") %>%
    mutate(Undernourished = str_replace_all(Undernourished, "<", "")) %>%
    mutate(Undernourished = as.numeric(Undernourished))

  return(covid_19)
}

# Setup the map for chart plotting
country_shape <- map_data("world2") %>%
  rename(country = region)
