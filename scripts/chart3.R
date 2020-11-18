library(lintr)
# Obesity V.S. Confirmed
# What is the relationship between obesity and the chance of COVID-19 infection?

chart_3 <- function(data) {
  obesity_confirmed <- data %>%
    mutate(
      confirmed_numb = Confirmed / 100 * Population,
      obesity_numb = Obesity / 100 * Population
    ) %>%
    mutate(Region = forcats::fct_explicit_na(Region)) %>%
    group_by(Region) %>%
    select(Region, obesity_numb, confirmed_numb, Population) %>%
    summarise(obesity_numb = sum(obesity_numb),
              confirmed_numb = sum(confirmed_numb),
              Population = sum(Population)) %>%
    drop_na(obesity_numb, confirmed_numb) %>%
    mutate(percent_obesity = round(obesity_numb / Population * 100, 2),
           percent_confirmed = round(confirmed_numb / Population * 100, 2))

  col_chart_obesity_confirmed <- ggplot(obesity_confirmed) +
    geom_col(mapping = aes(x = reorder(Region, -percent_confirmed),
                           y = percent_obesity,
                           fill = percent_confirmed)) +
    labs(
      title = "Obesity V.S. Confirmed",
      x = "Region",
      y = "% of Obesity",
      fill = "% of COVID confirmed out of Region population"
    )    +
    theme(axis.text.x = element_text(angle = 65, hjust = 1))

  return(col_chart_obesity_confirmed)
}
