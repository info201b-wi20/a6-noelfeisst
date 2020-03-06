# libraries
library("ggplot2")
library("shiny")
library("dplyr")
library("plotly")

# Page one
page_one <- tabPanel(
  "Poverty in the Midwest",
  titlePanel("Poverty"),

  # sidebar layout
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "poverty",
        label = "Average Poverty per Age Group",
        choices = list(
          "Known Poverty" = "percpovertyknown",
          "Child Poverty" = "percchildbelowpovert",
          "Adult Poverty" = "percadultpoverty",
          "Elderly Poverty" = "percelderlypoverty"
        )
      ),
      radioButtons(
        inputId = "color",
        label = "Bar Graph Color",
        choices = list(
          "Blue" = "blue",
          "Black" = "black",
          "Purple" = "purple",
          "Pink" = "pink"
        )
      )
    ),
    mainPanel(
      h3("Average Poverty Within Different 
         Age Demographics Per Midwest State"),
      plotlyOutput("bargraph"),
    )
  )
)

# Second page
page_two <- tabPanel(
  "College Demographics",
  titlePanel("College Demographics"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "race",
        label = "Race Demographics",
        choices = list(
          "Poverty Known" = "percpovertyknown",
          "Percent White" = "percwhite",
          "Percent Black" = "percblack",
          "Percent American Indian" = "percamerindan",
          "Percent Asain" = "percasian",
          "Percent Other" = "percother"
        )
      ),
      sliderInput(
        inputId = "size",
        label = "Point Size",
        min = .5,
        max = 5,
        value = 1,
        step = .5,
        ticks = TRUE
      )
    ),
    mainPanel(
      h4("The percent of people who have been to college 
         compared to the percent of known poverty/race in 
         different counties of midwest states."),
      plotlyOutput("scatterplot"),
    )
  )
)

# Creating page
ui <- navbarPage(
  "Midwest Poverty and College Demographics",
  page_one,
  page_two
)
