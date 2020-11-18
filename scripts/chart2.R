# The second chart shows the comfirmed case of covid-19 for
# each continent in a pei chart
chart_2 <- function(data) {
  library(RColorBrewer)
  
  df <- data %>%
    filter(!is.na(Confirmed), !is.na(Population), !is.na(Region)) %>%
    mutate(Case = Confirmed * Population / 100) %>%
    select(Region, Case) %>%
    group_by(Region) %>%
    summarise(Case = sum(Case, na.rm = T))

  deaths_conti <- df %>%
    ggplot(aes(x = "", y = Case, fill = Region)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar("y", start = 0) +
    labs(
      title = "Death Rate for Each Region"
    )
  
  nb.cols <- 20
  mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(nb.cols)
  
  deaths_conti <- deaths_conti + scale_fill_manual(values = mycolors)
  
  return(deaths_conti)
}
