library(shiny)
library(ggplot2)
library(xtable)
library(car)

shinyUI(pageWithSidebar(
    headerPanel("One-Way Analysis of Variance"),

    sidebarPanel(
      selectInput("n", label = "Sample Size per Group",
                  choices = c(10,30,100,250), selected = 30),
      selectInput("type", label = "Type of Plot", 
                  choices = c("Density", "Boxplot", "Histogram"), selected = "Density"),
      sliderInput("m1", label = "Group 1 Mean", min = 40, max = 60, 
                  value = 50, step = 1),
      sliderInput("s1", label = "Group 1 SD", min = 1, max = 10,
                  value = 5, step = 1),
      sliderInput("m2", label = "Group 2 Mean", min = 40, max = 60, 
                  value = 50, step = 1),
      sliderInput("s2", label = "Group 2 SD", min = 1, max = 10,
                  value = 5, step = 1),
      sliderInput("m3", label = "Group 3 Mean", min = 40, max = 60, 
                  value = 50, step = 1),
      sliderInput("s3", label = "Group 3 SD", min = 1, max = 10,
                  value = 5, step = 1),
      checkboxInput("posthoc", label = "Output post-hoc comparisons?", 
                    value = FALSE)
    ),

    mainPanel(
      helpText('Use the controls on the left to change sample size per group, plot type, and the means/standard deviations for each group.'),
      plotOutput("ANOVAplot"), 
      h3('ANOVA Summary Table'),
      verbatimTextOutput("summary"),
      verbatimTextOutput("posthoc1"),
      verbatimTextOutput("posthoc2")
      )
))
