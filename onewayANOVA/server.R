library(shiny)

shinyServer(function(input, output, session) {
    
    data <- reactive({
      N <- input$n
      g1 <- rnorm(n = N, mean = input$m1, sd = input$s1)
      g2 <- rnorm(n = N, mean = input$m2, sd = input$s2)
      g3 <- rnorm(n = N, mean = input$m3, sd = input$s3)
      data.frame(X = c(g1, g2, g3), 
                 Group = c(rep("Group1", N), rep("Group2", N), rep("Group3", N)))
    })
    
    output$ANOVAplot <- renderPlot({
      dat <- data()
      if(input$type == "Boxplot"){
        qplot(x = Group, y = X, data = dat, geom = "boxplot") + 
          stat_summary(fun.y=mean, colour="red", size=5, geom="point")
      } else if (input$type == "Histogram"){
        qplot(x = X, 
              data = dat, 
              facets = ~ Group)
      } else {
        qplot(x = X, data = dat, colour = Group, geom = "density")
      }
    })
    
    output$summary <- renderPrint({
      Anova(aov(X~Group, data=data()))
    })
    
    output$posthoc1 <- renderPrint({
      if(input$posthoc == TRUE){
        pairwise.t.test(data()$X, data()$Group, p.adjust.method="bonferroni")
      }
    })
    
    output$posthoc2 <- renderPrint({
      if(input$posthoc == TRUE){
        TukeyHSD(aov(X~Group, data=data()))
      }
    })
   
})