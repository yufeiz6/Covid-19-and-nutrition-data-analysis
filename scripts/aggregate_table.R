# A function that takes in a dataset and return a table of aggregate
# information want to find out how the diet structure correlate to the
# recovery from covid-19. Explore the proportion of protein and vitamine
# take in and the obesity rate for those recovered people from different
# region. This can provide people information about how they should adjust
# their diet to prevent or recover from covid-19.

aggregate_table <- function(dataset) {
  table <- dataset %>%
    mutate(protein_rate = Eggs +
                          Fish..Seafood +
                          Meat +
                          Milk...Excluding.Butter) %>%
    mutate(fruit_and_veges = Fruits...Excluding.Wine +
                             Vegetal.Products) %>%
    filter(!is.na(Region)) %>%
    group_by(Region) %>%
    summarise(recovered_rate = mean(Recovered, na.rm = TRUE),
              protein_rate = mean(protein_rate, na.rm = TRUE),
              obesity_rate = mean(Obesity, na.rm = TRUE),
              fruit_and_veges = mean(fruit_and_veges, na.rm = TRUE)
              ) %>%
    arrange(-recovered_rate) %>%
    top_n(10) %>%
    mutate(recovered_rate = paste0(round(recovered_rate, 2), "%"),
           protein_rate = paste0(round(protein_rate, 2), "%"),
           obesity_rate = paste0(round(obesity_rate, 2), "%"),
           fruit_and_veges = paste0(round(fruit_and_veges, 2), "%")
           )
    return(table)
}
