# Title: server.R
# Purpose: runs calculator

server <- function(input, output) {
  
  # Use reactiveVal to create a container for calculator result.
  container_risk <- reactiveVal(NULL)
  
  # When button clicked, run calculation and store the result
  observeEvent(input$calculate, {
    predrisk <- riskcalc(
      FirstRegYear = 2015, #set to latest year from original study
      FAge = input$FAge,
      duryrsWin = input$duryrsWin,
      BMIWin = input$BMIWin,
      FSecInf = as.numeric(input$FSecInf),
      EverSmoke = as.numeric(input$EverSmoke),
      EverAlc = as.numeric(input$EverAlc),
      spermdx = as.numeric(input$spermdx),
      endometdx = as.numeric(input$endometdx),
      ovulatory = as.numeric(input$ovulatory),
      Unexplained = as.numeric(input$Unexplained),
      Tubal = as.numeric(input$Tubal),
      other = as.numeric(input$other)
    )
    
    # Store result in reactive container
    container_risk(predrisk)
    })
  
  # Render the text output when container updated.
  
  output$risk_output <- renderText({
    # req() ensures this doesn't run until the container_risk container has a stored value.
    req(container_risk())
    
    # fetch value from container
    predrisk2 <- container_risk()
    paste0("Estimated chance: ", predrisk2 * 100, "%")
  })
  
  output$interpretation_text <- renderText({
    # req to ensure only appears once calculation completed
    req(container_risk())
    
    predrisk3 <- container_risk()
    
    predrisk3_precise <- round(predrisk3 * 100, 1)
    predrisk3_rounded <- round(predrisk3 * 100, 0)
    
    paste0(
      "<p style = 'font-size: 14px; colour: #303030; '>",
      "<strong>", "What does this result mean for me? ", "</strong>",
      "A predicted chance of ",
      "<strong>", predrisk3_precise, "%</strong>",
      " means that if there were 100 couples with similar characteristics to those you selected above, ",
      "<strong>", predrisk3_rounded, "</strong>",
      " of these couples are estimated to have a treatment-independent live birth from a pregnancy that started in the first year from diagnosis. ",
      "This also means that ",
      "<strong>", (100 - predrisk3_rounded), "</strong>",
      " of these couples are estimated to not have a treatment-independent live birth in the same timeframe.",
      "</p>"
    )
  })
}

