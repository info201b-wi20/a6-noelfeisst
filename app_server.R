# libraries
library("ggplot2")
library("shiny")
library("dplyr")
library("plotly")

server <- function(input, output) {
  # scatterplot ouput
  output$scatterplot <- renderPlotly({
    y_axis_name <- input$race
    MW_plot <- ggplot(data = midwest) +
      geom_point(
        mapping = aes
        (
          x = percollege,
          y = !!as.name(y_axis_name),
          color = state,
          text = paste0("County: ", county)
        ),
        size = input$size
      ) +
      labs(
        title = "Percent of College Vs. Poverty/Race",
        x = "Percent of Population Who Have Been to College",
        y = input$race,
        color = "State"
      )
    return(ggplotly(MW_plot))
  })
  # bargraph output
  output$bargraph <- renderPlotly({

    # mutating to create new column with input grouped by state
    average_poverty <- midwest %>%
      group_by(state) %>%
      mutate(avr_poverty = mean(!!as.name(input$poverty), na.rm = TRUE))

    # creating bargraph
    bargraph_MD <- plot_ly(
      data = average_poverty,
      x = ~state,
      y = ~ avr_poverty / 100,
      type = "bar",
      alpha = .9,
      color = I(input$color)
    ) %>%
      layout(
        xaxis = list(title = "State"),
        yaxis = list(title = paste0("Average ", input$poverty))
      )
    return(ggplotly(bargraph_MD))
  })
}
