library(UsingR)
data(nym.2002)
# set up data splits that will be used multiple times:
nym.m <- nym.2002[nym.2002$gender=="Male",]
nym.f <- nym.2002[nym.2002$gender=="Female",]
# set up some re-used text, hist break param, and summaries
xtext <- "Finish time (min)"
ytext <- "Frequency"
brks <- seq(140,580,by=20)
htitle <- "NY Marathon 2002 Finish Times Frequency Distribution"
ptitle <- "NY Marathon 2002 Finish Times by Runner's Age"
summ.all <- summary(nym.2002$time)
summ.m <- summary(nym.m$time)
summ.f <- summary(nym.f$time)

shinyServer(
    function(input, output) {
        # show histogram for all, men, or women
        output$nymHist <- renderPlot({
            if (input$plotMode =="blended") {
                hist(nym.2002$time, breaks=brks, xlab=xtext, ylab=ytext, col='chartreuse4', 
                     main=paste(htitle,'(all runners in sample)'))
            } else if (input$plotMode =="male") {
                hist(nym.m$time, breaks=brks, xlab=xtext, ylab=ytext, col='cyan4', 
                     main=paste(htitle,'for Men'))
            } else if (input$plotMode =="female") {
                hist(nym.f$time, breaks=brks, xlab=xtext, ylab=ytext, col='brown4', 
                     main=paste(htitle,'for Women'))
            }
        })

        summ <- reactive({
            if (input$plotMode =="blended") {
                summ.all
            } else if (input$plotMode =="male") {
                summ.m
            } else if (input$plotMode =="female") {
                summ.f
            }
        })
        output$summMin <- renderText(summ()["Min."])
        output$summ1Q <- renderText(summ()["1st Qu."])
        output$summMed <- renderText(summ()["Median"])
        output$summMean <- renderText(summ()["Mean"])
        output$summ3Q <- renderText(summ()["3rd Qu."])
        output$summMax <- renderText(summ()["Max."])

        output$nymPlot <- renderPlot({
            if (!"showGender" %in% input$plotOpt) {
                plot(nym.2002$age, nym.2002$time, xlab="Runner's Age", ylab="Finish time (min)",
                     main=ptitle, pch=21, bg="chartreuse3", col="chartreuse4")
                if ("showLm" %in% input$plotOpt) {
                    abline(lm(nym.2002$time ~ nym.2002$age), lwd=2, col="chartreuse4")   
                }
            } else {
                plot(nym.2002$age, nym.2002$time, xlab="Runner's Age", 
                     ylab="Finish time (min)", main=ptitle, type="n")
                points(nym.m$age, nym.m$time, pch=22, bg="cyan3", col="darkcyan")
                points(nym.f$age, nym.f$time, pch=24, bg="brown3", col="brown4")
                legend("topleft", pch=c(22,24), col=c("cyan4","brown4"), 
                       pt.bg=c("cyan3","brown3"), legend=c("Male", "Female"))
                if ("showLm" %in% input$plotOpt) {
                    abline(lm(nym.m$time ~ nym.m$age), lwd=2, col="darkcyan")   
                    abline(lm(nym.f$time ~ nym.f$age), lwd=2, col="brown4")   
                }
            }
        })

    }
)
