library(shiny)
library(ggplot2)
library(plotly)
library(stringr)
library(dplyr)

df <- read.csv("./data/covid-19-healthy-diet/Food_Supply_Quantity_kg_Data_final.csv",
               stringsAsFactors = F)

country_code <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv",
                        stringsAsFactors = F)

country_code <- country_code %>%
  rename(country = COUNTRY) %>%
  rename(code = CODE) %>%
  select(country, code)

joined_data <- left_join(df, country_code, by = "country")

server <- function(input, output) {

  output$page_1 <- renderPlotly({
    df_select <- df %>%
      filter(Active > input$active[1] &
                 Active < input$active[2],
               Confirmed > input$confirmed[1] &
                 Confirmed < input$confirmed[2])
    p <- ggplot(df_select, aes(x = Confirmed, y = Active)) +
      geom_point(aes(col = Region, size = Obesity)) +
      geom_smooth(method = "loess", se = T) +
      xlim(c(0, 0.625322581)) +
      ylim(c(0, 0.313934249)) +
      labs(y = "% of COVID active cases out of country population",
           x = "% of COVID confirmed cases out of country population",
           title = "Active by Confirmed",
           caption = "Source: Food_Supply_Quantity_kg_Data_final",
           size = "% of Obesity in ")
    p
  })

  output$page_2_1 <- renderPlotly({

    p1 <- plot_ly(joined_data, type = "choropleth",
                  locations = joined_data$code,
                  z = joined_data[, input$statvar],
                  color = joined_data[, input$statvar],
                  text = joined_data$country, colorscale = "Viridis",
                  reversescale = TRUE) %>%
      colorbar(title = "% of Population") %>%
      layout(
        title = paste(input$statvar, "vs. Countries")
      )
    p1
  })

  output$page_2_2 <- renderPlotly({
    p2 <- plot_ly(joined_data, type = "choropleth",
                  locations = joined_data$code,
                  z = joined_data[, input$foodvar],
                  color = joined_data[, input$foodvar],
                  text = joined_data$country, colorscale = "Reds") %>%
      colorbar(title = "% of Population") %>%
      layout(
        title = paste(input$foodvar, "vs. Countries")
      )

    p2
  })

  output$page_3_1 <- renderPlot({
    var <- df %>%
      mutate(protein = Eggs +
               Fish..Seafood +
               Meat +
               Milk...Excluding.Butter) %>%
      mutate(vitamine = Fruits...Excluding.Wine +
               Vegetal.Products) %>%
      mutate(fat = Obesity) %>%
      filter(!is.na(Region)) %>%
      group_by(Region) %>%
      summarise(recovered_rate = mean(Recovered, na.rm = TRUE),
                protein = mean(protein, na.rm = TRUE),
                fat = mean(fat, na.rm = TRUE),
                vitamine = mean(vitamine, na.rm = TRUE)
      ) %>%
      arrange(-recovered_rate) %>%
      top_n(10)

    var2 <- data.frame(
      Region = var$Region,
      rate = paste0(round(var[[input$choice]], 1), "%")
    )

    p <- ggplot(var2) +
      geom_col(mapping = aes(x = Region, y = rate, fill = Region)) +
      labs(
        title = paste(input$choice,
                      "rate in regions with top 10 recovered cases"),
        x = "Regions with top 10 recovery rate",
        y = paste(input$choice, "in percentage")
      )
    p
  })

  output$page_3_2 <- renderTable({
    table <- df %>%
      mutate(protein = Eggs +
               Fish..Seafood +
               Meat +
               Milk...Excluding.Butter) %>%
      mutate(vitamine = Fruits...Excluding.Wine +
               Vegetal.Products) %>%
      mutate(fat = Obesity) %>%
      filter(!is.na(Region)) %>%
      group_by(Region) %>%
      summarise(recovered_rate = round(mean(Recovered, na.rm = TRUE), 4),
                protein = round(mean(protein, na.rm = TRUE), 2),
                fat = round(mean(fat, na.rm = TRUE), 2),
                vitamine = round(mean(vitamine, na.rm = TRUE), 2)
      ) %>%
      arrange(-recovered_rate) %>%
      top_n(10)
    table
  })

  # Conclusions
  obesity_confirmed <- df %>%
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
    filter(!is.na(obesity_numb), !is.na(confirmed_numb)) %>%
    mutate(percent_obesity = round(obesity_numb / Population * 100, 2),
           percent_confirmed = round(confirmed_numb / Population * 100, 2))

  output$conclusion_1 <- renderPlot({
    p1 <- ggplot(obesity_confirmed) +
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

    p1
  })

  output$conclusion_2 <- renderPlotly({
    x <- list(title = "% of Undernourished People/Country Population")
    y <- list(title = "% of COVID Recovered Cases/Country Population")

    p2 <- plot_ly(data = joined_data, x = ~Undernourished, y = ~Recovered) %>%
      layout(xaxis = x,
           yaxis = y)
    p2
  })

  output$conclusion_3 <- renderTable({
    table <- df %>%
      mutate(protein = Eggs +
               Fish..Seafood +
               Meat +
               Milk...Excluding.Butter) %>%
      mutate(vitamine = Fruits...Excluding.Wine +
               Vegetal.Products) %>%
      mutate(fat = Obesity) %>%
      filter(!is.na(Region)) %>%
      group_by(Region) %>%
      summarise(recovered_rate = round(mean(Recovered, na.rm = TRUE), 4),
                protein = round(mean(protein, na.rm = TRUE), 2),
                fat = round(mean(fat, na.rm = TRUE), 2),
                vitamine = round(mean(vitamine, na.rm = TRUE), 2)
      ) %>%
      arrange(-recovered_rate) %>%
      top_n(10)
    table
  })
}
