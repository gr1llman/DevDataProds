library(shiny)


shinyUI(
    tabsetPanel(
      tabPanel(h4("NHL Statistics", style = "color : blue"),
        fluidPage(
                fluidRow(
#
# Page title
#                      
                     
                 column(12, align="center",
                    h1("NHL 2014-15 Statistics by Country of Birth",
                       style = "color : blue") 
                  )
                ),
                fluidRow( 
                  column(3, style = "background-color: rgba(0,0,255,0.10)",
#
# Input drop down list
#                           
                        selectInput("Country", 
                                    label="Select a Birth Country",
                                    choices=list(
                                            "Austria"="AUT",
                                            "Belarus"="BLR",
                                            "Brazil"="BRA",
                                            "Brunei Darussalam"="BRN",
                                            "Canada"="CAN",
                                            "Croatia"="HRV",
                                            "Czech Republic"="CZE",
                                            "Denmark"="DNK",
                                            "Estonia"="EST",
                                            "Finland"="FIN",
                                            "France"="FRA",
                                            "Germany"="DEU",
                                            "Italy"="ITA",
                                            "Latvia"="LVA",
                                            "Lithuania"="LTU",
                                            "Norway"="NOR",
                                            "Russia"="RUS",
                                            "Slovakia"="SVK",
                                            "Slovenia"="SVN",
                                            "Sweden"="SWE",
                                            "Switzerland"="CHE",
                                            "United States"="USA"),
                                    selected="USA"
                                  ),
                        helpText("Based on National Hockey League data",
                                 "compiled and summarized in XLS format",
                                 "by Rob Vollman, available at ",
                                 a("http://www.hockeyabstract.com", 
                                   href="http://www.hockeyabstract.com"),
                         style = "background-color: rgba(0,0,0,0.10);
                                color: black"),
#
# Output scoring stats
#
                        tags$style("#players{color: red}"),
                        textOutput('players'),
                        h3("Scoring Statistics",
                           style = "background-color: rgba(0,0,128,0.20);
                                   color: navy"),
                        h5("(Country / NHL (PCT%))"),                       
                        h4("Total goals scored",
                           style = "background-color: rgba(0,0,128,0.10);
                           color: navy"),
                        textOutput('goals'),
                        h4("Total games played",
                           style = "background-color: rgba(0,0,128,0.10);
                           color: navy"),
                        textOutput('games'),
                        h4("Goals per game played",
                           style = "background-color: rgba(0,0,128,0.10);
                           color: navy"),
                        textOutput('gpg'),
#
# Output personal characteristics
#
                        br(),
                        h3("Personal Characteristics",
                           style = "background-color: rgba(128,0,128,0.20);
                           color: purple"),
                        h5("(Country / NHL)"),
                        h4("Average age",
                           style = "background-color: rgba(128,0,128,0.10);
                           color: purple"),
                        textOutput('avg_age'),
                        h4("Average height",
                           style = "background-color: rgba(128,0,128,0.10);
                           color: purple"),
                        textOutput('avg_ht'),
                        h4("Average weight",
                           style = "background-color: rgba(128,0,128,0.10);
                           color: purple"),
                        textOutput('avg_wt')
                 ),
                  column (9,
                        plotOutput('goals_plot'),
                        plotOutput('games_plot')
                  )
              )
        )
      ),
        tabPanel(h4("About / Using this Application", style = "color : red"),
               h1("NHL 2014-15 Statistics by Country of Birth",
                    style = "color : blue", align = "center"),               
               h2("Background"),
               textOutput('about', inline = TRUE), 
               a("http://www.coursera.org", href="http://www.coursera.org"),
               h2("Disclaimer"),
               textOutput('disclaim', inline = TRUE),
               a("http://www.hockeyabstract.com", 
                 href="http://www.hockeyabstract.com"),
               h2("Using this application"),
               textOutput('using'),
               h2("Information provided"),
               textOutput('information')
               
      )
    )  
)