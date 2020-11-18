library(shiny)
library(dplyr)

# Overview Page
overview_page <- tabPanel(
  "Overview",

  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    ")),
    tags$link(rel = "stylesheet", type = "text/css",
              href = "bootstrap.min (1).css")
  ),

  tags$h1("COVID-19 and Our Daily Life"),

  tags$h3("Section BC   Xinyu Wang, Shaosui Hong, Crystal Wen, Yufei Zhang"),

  tags$img(src = "https://thumbs-prod.si-cdn.com/bvysf4t6oPfkpAfd7TJ0DBUaNX8=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/79/4a/794a7e74-8c99-4fde-abcd-a303bc302ba1/sars-cov-19.jpg",
           height = 300, width = 400),

  tags$p(
    tags$style(HTML("p {
        font-family:  'Times New Roman', Times, serif;
        font-size: 115%;
        line-height: 1.1; }")),

    tags$br(),

    tags$b(" The first half of 2020 is a big shock for us.
Covid-19 has swept the globe and has had an inestimable
impact on the lives of people all over the world.
Because of this epidemic, we have lost tens of thousands of lives.
In such a condition, our group wants to do our best to help people,
even only a tiny number of people. In this report,
we focused on the topic of nutrition and its correlation with COVID-19."),

    tags$p("- Does the amount of food supply
           affect cases concerning Covid-19?"),

    tags$p("- Does the obesity rate of people affect the confirmed and active
           cases of COVID-19?"),

    tags$p("- Which kind of nutrient has the most
           positive effect on people under such a condition?"),

    tags$h3("Below are some resources that can help you learn more about
           COVID-19:"),

    tags$a(href = "https://www.cdc.gov/coronavirus/2019-ncov/index.html",
           "- The official site of COVID-19 published by Center of Disease
           Dontrol and Prevention"),

    tags$br(),

    tags$a(href = "https://news.google.com/covid19/map?hl=en-US&mid=/m/0mmpz&gl=US&ceid=US:en",
           "- Google COVID-19 Statistic Information"),

    tags$br(),

    tags$a(href = "https://www.youtube.com/watch?v=cRy5_KpPxyM",
           "- Coronavirus Live Map and realtime counter"),

    tags$br(),

    tags$embed(
      src = "https://www.youtube.com/embed/cRy5_KpPxyM",
      type = "video/mp4",
      height = 620,
      width = 1000
    ),
    tags$h3("Source"),
    tags$a(href = "https://www.kaggle.com/mariaren/covid19-healthy-diet-dataset",
           "- COVID-19 Healthy Diet Dataset"),
    tags$br(),
    tags$a(href = "https://www.kaggle.com/ofrancisco/emoji-diet-nutritional-data-sr28",
           "- Emoji Diet Nutritional Data"),
    tags$br(),
    tags$a(href = "https://www.kaggle.com/trolukovich/nutritional-values-for-common-foods-and-products",
           "- Nutritional values for common foods and products"),
  )
)

# Page 1
range_confirmed <- range(df$Confirmed)

confirmed_input <- sliderInput(
  "confirmed",
  label = "Percentage of Number Confirmed",
  min = min(df$Confirmed, na.rm = T),
  max = max(df$Confirmed, na.rm = T),
  value = range_confirmed
)

active_range <- range(df$Active)

active_input <- sliderInput(
  "active",
  label = "Percetage of COVID Active Cases",
  min = min(df$Active, na.rm = T),
  max = max(df$Active, na.rm = T),
  value = active_range
)

page_1_panel <- tabPanel(
  "Active Cases by Confirmed Cases",
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    ")),
    tags$link(rel = "stylesheet", type = "text/css",
              href = "../scripts/www/bootstrap.min (1).css")
  ),
  headerPanel("Active by Confirmed"),
  sidebarLayout(
    sidebarPanel(confirmed_input, active_input),
    mainPanel(plotlyOutput("page_1"),
              br(),
              p("In this scatterplot,
                we are trying to find the correlation between obesity
                and the chance of COVID-19 infection.",
                style = "font-family: 'times'; font-si16pt"),
              p("Therefore, the best way to visualize this correlation
                is through a scatterplot."),
              p("The size of the circle indicates the percentage of Obesity.
                The bigger the circle, the larger the obesity rate.
                We could also identify each region by color.
                And it seems like there is no direct correlation between
                Obesity and the COVID 19 infection rate.")
))
  )



# Page 2
covid_stats_cols <- colnames(df[, 27:30])
food_supply_cols <- colnames(df[, 2:24])
food_supply_cols <- append(food_supply_cols, "Undernourished")

sidebar_content1 <- sidebarPanel(

  selectInput(
    inputId = "statvar",
    label = "Covid-19 Statistics",
    choices = covid_stats_cols,
    selected = "Confirmed"
  )
)

sidebar_content2 <- sidebarPanel(
  selectInput(
    inputId = "foodvar",
    label = "Food Supply",
    choices = food_supply_cols,
    selected = "Alcoholic.Beverages"
  )
)

main_content1 <- mainPanel(
  plotlyOutput("page_2_1")
)

main_content2 <- mainPanel(
  plotlyOutput("page_2_2")
)

page_2_panel <- tabPanel(
  "Covid-19/Food Supply Maps",

  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    ")),
    tags$link(rel = "stylesheet", type = "text/css",
              href = "../scripts/www/bootstrap.min (1).css")
  ),

  tags$h1("Covid-19 Statistics/Food Supply"),

  tags$p(
    tags$style(HTML("p {
        font-family:  'Times New Roman', Times, serif;
        font-size: 130%;
        line-height: 1.1; }")),

    tags$br("With these maps, we are trying to find a relationship between
    Covid-19 statistics and countries with certain amounts of food supplies."),

    tags$br("We believe a heatmap related
    to these numbers can best show these relationships"),

    tags$br("since we can easily see the statistics of
            individual countries and their food supplies."),

    tags$br("Furthermore, we can easily generalize by regions."),

    tags$br("(Countries that are white are those without any information)")),

  sidebarLayout(
    sidebar_content1,
    main_content1
  ),

  sidebarLayout(
    sidebar_content2,
    main_content2
  )
)

# Page 3
page_3_panel <- tabPanel(
  "Nutrients and Recovery Rate",

  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    ")),
    tags$link(rel = "stylesheet", type = "text/css",
              href = "bootstrap.min (1).css"),
  ),

  h1("Nutrition VS Recovery"),
  p("We are trying to present how different types of nutrition may affect
    recovery from covid-19. We choose to display their effect through bar
    graph."),

  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "choice",
        label = "type of nutrition",
        choices = list(protein = "protein", fat = "fat", vitamine = "vitamine"),
        selected = "protein"
      )
    ),
    mainPanel(
      plotOutput("page_3_1")
    )
  )
)
# Conclusion Page
conclusion_page <- tabPanel(
  "Conclusion Takeaways",
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }
      h3 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: MediumSeaGreen;
      }
      p {
      background-color: Snow
      }
            b {
      background-color: Snow
      }
    ")),
    tags$link(rel = "stylesheet", type = "text/css",
              href = "../scripts/www/bootstrap.min (1).css")
  ),

  tags$h1("Here is What We Found"),


  #Page_1_panel takeaway
  h3("Obesity and COVID Infection Rate"),
  p("As we all know, obesity has always been one of the main public
    health problems facing the country. This time, the outbreak
    of COVID-19 gives this problem a more visible expression."),
  br(),
  plotOutput("conclusion_1"),
  br(),
  p("The chart indicates that NorthernAmerica has both the highest % of
    obesity and % of COVID confirmed cases.
    However, the region that has the second-highest % of COVID confirmed cases,
    does not have the second-highest % of Obesity,
    which shows that there is no obvious correlation between obesity and the
    chance of COVID-19 infection.
    But the chart also indicates that the Regions that have
    a lower % of COVID confirmed cases also have a very low % of obesity,
    such as eastern Asia, MiddleAfrica, southern Asia, eastern Africa,
    and western Africa."),
  p("Although, it is obvious that obesity does not directly correlate with the chance of COVID infection,
  but maintain a healthy body should always be our top priority.
  Having a healthy body can not only help you block the virus
  out but also help you defeat the virus in a faster way.
  In other words, your health is your life."),

  #Page_2_panel takeaway

  h3("Undernourished Rate and Recovery Rate"),
  p("A notable pattern that was found from the maps is that there seems to be
    no direct, or any, relationship between percentages of undernourished
    people and percentages of recovery in a country."),
  p("This pattern is true for any food supplies and other Covid-19
    statistics."),
  br(),
  plotlyOutput("conclusion_2"),
  br(),
  p("While we have no direct relationship, it is important to note that the
    countries with the most data comes from developed countries. There are
    possiblities of countries changing or hiding data from the public.
    Moreover, this is an ongoing pandemic which means these Covid-19 statistics
    will constantly change. Furthermore, there are other factors that could
    play into the number of recovered cases in a country, such as: population
    density, government policies, culture, etc. Lastly, while there is no
    relationship between nourishment and recovery, nutrition is a factor we
    cannot dismiss, as it is proven that a person's nutrition plays a role in
    his/her health/immunity."),

  # Page_3_panel takeaway
  h3("Different Nutritions and Recovery Rate"),
  p("We tried to figure out if there are any type of nutritrients that may have
    a correlation to a person's recovery from the disease. This may indicate
    that people should take more of a particular nutrient to maintan a healthy
    state. We extracted the supplies percentages of fat, protein, and  vitamin
    as three different nutrients from foods in our dataset"),
  p("This is a table that lists all 3 types of nutrients
    from ten regions with a high recovery rate"),
  br(),
  tableOutput("conclusion_3"),
  br(),
  p("The table, as well as the bar graph, indicate there is no direct
    correlation between recovery rate and these three nutrients. However, it
    demonstrates that countries with a higher recovery rate generally have
    protein supplies around 6% to 12%, and vitamins around 45% to 50%. We could
    improve our explorations by taking different types of nutrients into
    account, such as dietary fiber and sugar, or specify the kind of food that
    contribute to our health. Moreover, we could come up with a table of the
    ten countries with the lowest recovery rates with the same nutrients.
    This may provide us with more obvious clues to which type of nutrients
    would be helpful in order to maintain a healthy state.")
)

ui <- navbarPage(
    "COVID-19 and Our Daily Life",
    overview_page,
    page_1_panel,
    page_2_panel,
    page_3_panel,
    conclusion_page,
    inverse = T
)
