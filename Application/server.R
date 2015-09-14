library(ggplot2)

data(mtcars)

shinyServer(function(input, output) {
    
    mtcarsColNames <- colnames(mtcars)
    
    output$colNamesDropdown1 <- renderUI({selectInput("colNamesDropdown1", "Choose first variable: ", mtcarsColNames)})
    output$colNamesDropdown2 <- renderUI({selectInput("colNamesDropdown2", "Choose second variable: ", mtcarsColNames)})

    output$plot <- renderPlot(
        ggplot(mtcars, aes_string(input$colNamesDropdown1, input$colNamesDropdown2))  + 
            geom_point(aes(colour = rownames(mtcars)), size = input$size) + 
            guides(colour = FALSE) + 
            geom_text(aes(label = rownames(mtcars)), hjust = -input$size / 50, vjust = -input$size / 50, size = input$size / 2) +
            stat_smooth(method = "lm", se = FALSE)
    )
    
    observeEvent(input$btnSubmit, {
        lmFormula <- paste(input$colNamesDropdown1, input$colNamesDropdown2, sep = "~")
        lmModel <- lm(as.formula(lmFormula), mtcars)
        lmSummary <- summary(lmModel)

        output$modelSummaryText <- renderText(paste("formula = ", lmFormula))
        output$modelSummaryPrint <- renderPrint(lmSummary)
        output$modelPlot <- renderPlot(plot(lmModel, which = 1))
    })
})