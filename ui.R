# Title: ui.R
# Purpose: defines user-interface of calculator


ui <- fluidPage(
  titlePanel("Treatment-independent live birth prediction calculator"),
  sidebarLayout(
    sidebarPanel(
      h4("Couple Details"),
      numericInput(
        "FAge",
        "Female age:",
        value = 30,
        min = 18,
        max = 49,
        step = 1
      ),
      numericInput(
        "duryrsWin",
        "Duration of infertility (years):",
        value = 1,
        min = 0,
        max = 10,
        step = 0.5
      ),
      numericInput(
        "BMIWin",
        "Female BMI:",
        value = 25,
        min = 11,
        max = 42.5,
        step = 0.1
      ),
      # Radio buttons for binary inputs.
      radioButtons(
        inputId = "FSecInf",
        label = "History of previous pregnancy in female partner?",
        choices = c("Yes" = 1, "No" = 0),
        selected = 0
      ),
      
      radioButtons(
        inputId = "EverSmoke",
        label = "Has the female partner ever been a smoker?",
        choices = c("Yes" = 1, "No" = 0),
        selected = 0
      ),
      
      radioButtons(
        inputId = "EverAlc",
        label = "Any history of alcohol use in female partner?",
        choices = c("Yes" = 1, "No" = 0),
        selected = 0
      ),
      
      h4("Causes of infertility"),
      
      checkboxInput("spermdx", "Diagnosis of male factor infertility", value = FALSE),
      checkboxInput("endometdx", "Diagnosis of endometriosis", value = FALSE),
      checkboxInput("ovulatory", "Diagnosis of anovulatory infertility", value = FALSE),
      checkboxInput("Unexplained", "Diagnosis of unexplained infertility", value = FALSE),
      checkboxInput("Tubal", "Diagnosis of tubal infertility i.e. blocked, missing or damaged fallopian tube(s)?", value = FALSE),
      checkboxInput("other", "Other infertility diagnosis", value = FALSE)
    ),
    mainPanel(
      actionButton(inputId = "calculate",
                   label = "Calculate chance of live birth",
                   class = "btn-primary btn-lg"),
      hr(), # horizontal rule for separation
      
      h3(
        "Predicted probability of treatment-independent pregnancy within 365 days from diagnosis of infertility, leading to a live birth:"
      ),
      
      wellPanel(
        span(textOutput("risk_output"), style = "font-size:20px; font-weight: bold; color: #004a99")
        
      ),
      
      htmlOutput("interpretation_text"), #interpretation of result based on calculated risk
      
      hr(),
      
      tags$em( #make text italic
        p(
          tags$strong("DISCLAIMER:"), #makes the first word bold
          "This tool uses the information you have entered above to estimate the individual chance of a ",
          tags$strong("treatment-independent live birth"),
          ". ",
          "Specifically, it estimates the chance of spontaneous pregnancy occurring within the first year from a diagnosis of infertility (and before starting any treatment), with that pregnancy going on to lead to a live birth. ",
          "These estimates are based on the patient data we used when making this model, and represents the outcomes of couples with similar characteristics to those you have entered into the calculator. ",
          "As such, the estimate may not represent your experience. ",
          "This is particularly important in characteristics where we had fewer patients to base our estimates on, such as the higher age groups. ",
          "We would recommend to interpret these results with caution and alongside discussions with your medical team about your individual fertility journey."
        )
      )
  )
))
