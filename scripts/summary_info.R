# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(data) {
  ret <- list()

  # Finds the number of countries that are studied
  ret$length <- length(data)

  # Finds the highest death rate and the corresponding countries
  ret$highest_death <- data %>%
    filter(Deaths == max(Deaths, na.rm = TRUE)) %>%
    pull(Deaths) %>%
    round(digits = 2) %>%
    paste0("%")

  ret$highest_death_country <- data %>%
    filter(Deaths == max(Deaths, na.rm = TRUE)) %>%
    pull(country)

  # Finds the lowest death rate and the corresponding countries
   low_d <- data %>%
    filter(Deaths == min(Deaths, na.rm = TRUE)) %>%
    pull(Deaths)

  ret$lowest_death <- round(low_d[1], digits = 2) %>%
    paste0("%")

  ret$lowest_death_country <- data %>%
    filter(Deaths == min(Deaths, na.rm = TRUE)) %>%
    pull(country)

  # Finds the highest undernourished rate and the corresponding countries
  ret$highest_undernourished <- data %>%
    filter(Undernourished == max(Undernourished, na.rm = TRUE)) %>%
    pull(Undernourished) %>%
    round(digits = 2) %>%
    paste0("%")

  ret$highest_un_country <- data %>%
    filter(Undernourished == max(Undernourished, na.rm = TRUE)) %>%
    pull(country)

  # Finds the lowest undernourished rate and the corresponding countries
  low_u <- data %>%
    filter(Undernourished == min(Undernourished, na.rm = TRUE)) %>%
    pull(Undernourished)

  ret$lowest_undernourished <- round(low_u[1], digits = 2) %>%
    paste0("%")

  ret$lowest_un_country <- data %>%
    filter(Undernourished == min(Undernourished, na.rm = TRUE)) %>%
    pull(country)

  return(ret)
}
