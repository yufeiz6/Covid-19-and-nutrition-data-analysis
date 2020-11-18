library(shiny)
library(ggplot2)
library(plotly)
library(stringr)
library(dplyr)

source("./app_server.R")
source("./app_ui.R")

shinyApp(ui = ui, server = server)
