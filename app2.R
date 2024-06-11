
library(shiny)
library(tidyverse)

#library(babynames)

ui <- fluidPage(textInput(inputId = "len", label = "Length:", value = "", placeholder = "ToothLength"), 
                selectInput(inputId = "supp", label = "Support:", choices = list(Vitamin_C= "VC", Orange_juice = "OJ")),
                sliderInput(inputId = "dose", label = "Dose Range:", min = min(ToothGrowth$dose), max = max(ToothGrowth$dose),
                            value = c(min(ToothGrowth$dose), max(ToothGrowth$dose)), sep = ""),
                submitButton(text = "Generate Plot"),
                plotOutput( outputId = "Tooth_Dose_plot")
                
) 

server <- function(input, output) {
  output$Tooth_Dose_plot <- renderPlot(
    
    ToothGrowth %>%
    
   # babynames %>%
      filter(supp == input$supp, 
             len == input$len) %>%
      ggplot(aes(x = dose,
                 y = len)) + 
      geom_line() +
      scale_x_continuous(limits = input$dose) + 
      theme_minimal()
  )
}

shinyApp(ui = ui, server= server)