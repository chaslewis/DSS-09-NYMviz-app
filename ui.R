# setwd("C:/Users/Administrator/Google Drive/Coursera/DataScienceSpecialization/prog/coursera-data-science-specialization/09-DevelopingDataProducts")

shinyUI(
    fluidPage(
        headerPanel("New York Marathon 2002"),
        tabsetPanel(
            tabPanel("Start Here",
                     h1("Welcome to NYMviz"),
                     p("Each year, on the first Sunday in November, thousands of runners participate in the", 
                       tags$a(href="http://en.wikipedia.org/wiki/New_York_City_Marathon", "New York City Marathon"), "which is at once among the premier annual events in elite distance running and the largest marathon in the world."),
                     p("A dataset of a random sample of 1000 runners taken from the finishers of the 2002 New York City Marathon is available as part of the", 
                       tags$a(href="http://cran.r-project.org/web/packages/UsingR/UsingR.pdf", "Package 'UsingR'"), "(see p. 74).",
                       "NYMviz is an interactive online application allowing you to visualize the characteristics of this population and appreciate its diversity along several dimensions:"),
                     tags$ul(
                        tags$li("gender"),
                        tags$li("age"),
                        tags$li("time to finish the race")
                        ),
                     p('Click on the "Histogram" tab to view distributions of the finish times.  You may select one of the three radio buttons to view results for all runners ("Blended") or for "Male" or "Female".  
                       A summary table of the data being plotted is provided below the histogram.'),
                     p('Click on the "Scatter Plot" tab to view a plot which has a point for each runner in the sample showing finish time by age.  You may interact with the chart by cheking the two boxes in the "Plot Options" panel.  "Show 
                       by Gender" toggles coloring of the individual runner points by gender, while "Show Linear Regression" draws a straight line that best represents the runners\' results.  When "Show by Gender" is not (also) selected, a 
                       single regresion line is drawn for the entire sample; when "Show by Gender" is selected, two lines are drawn, one for male and one for female runners.')                     
                     
            ),
            tabPanel("Histogram",
                sidebarLayout(
                    sidebarPanel(
                        radioButtons("plotMode", "Select Gender View",
                                     c("Blended (male & female)"="blended",
                                       "Male"="male",
                                       "Female"="female"))
                        
                    ),
                    mainPanel(
                        plotOutput('nymHist'),
                        withTags(table(class="table",
                            tr(td("Min"), td("1st Qu."), td("Median"), 
                               td("Mean"), td("3rd Qu."), td("Max.")),
                            tr(td(textOutput('summMin')),
                               td(textOutput('summ1Q')),
                               td(textOutput('summMed')),
                               td(textOutput('summMean')),
                               td(textOutput('summ3Q')),
                               td(textOutput('summMax')))
                        ))
                        
                    )
                )
            ),
            tabPanel("Scatter Plot",
                sidebarLayout(
                    sidebarPanel(
                        checkboxGroupInput("plotOpt", "Plot Options", 
                                           c("Show by Gender (m/f)"="showGender",
                                             "Show Linear Regression"="showLm"))
                    ),
                    mainPanel(
                        plotOutput('nymPlot')
                    )
                )
            )
        )
    )
)
