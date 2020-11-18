# The first chart shows the undernourished rate for each country
chart_1 <- function(data, map) {
  df <- data %>%
    filter(!is.na(Undernourished)) %>%
    select(country, Undernourished)

  country_shape_un <- left_join(map, df, by = "country")

  country_un_rate <- ggplot(country_shape_un) +
    geom_polygon(
      mapping = aes(x = long, y = lat, group = group, fill = Undernourished),
      color = "white",
      size = 0.1
    ) +
    coord_map() +
    scale_fill_continuous(low = "#132b43", high = "red") +
    labs(title = "Global Undernourished Rate Map",
         fill = "Undernourished Rate (%)") +
    theme_bw() +
    theme(
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      plot.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.border = element_blank()
    )

  return(country_un_rate)
}
