#
# Open the file and do pre-processing, including correcting na values
#
library(shiny)
nhl <- read.csv('NHL2014-15.csv')
indx <- which(is.na(nhl$Draft) == TRUE)
nhl[indx, ]$Draft <- c("Undrafted")
#
# Calculate league wide stats
#                
nhl_goals <- sum(nhl$G)
nhl_games <- sum(nhl$GP)
nhl_avg_age <- format(mean(nhl$Age), digits=4)
nhl_avg_ht <- format(mean(nhl$HT), digits=4)
nhl_avg_wt <- format(mean(nhl$Wt), digits=5)
nhl_gpg <- format(sum(nhl$G) / sum(nhl$GP),digits=3)
nhl_players <- dim(nhl)[1]


shinyServer(
        function(input, output) {
#
# Subset for data for charts
#          
          pick <- reactive ({nhl[nhl$Ctry == input$Country, ]})
          chart_goals <- reactive ({tapply(pick()$G, pick()$Draft, sum)})
          chart_games <- reactive ({tapply(pick()$GP, pick()$Draft, sum)})
#
# Subset for data for charts
#                    
          pick_players <- reactive ({dim(pick())[1]})
          pick_goals <-  reactive ({sum(nhl[nhl$Ctry == input$Country,]$G)})
          pick_games <- reactive ({sum(nhl[nhl$Ctry == input$Country,]$GP)})
          pick_avg_age <-  reactive ({format(mean(
                  nhl[nhl$Ctry == input$Country, ]$Age), digits=4)})
          pick_avg_ht <-  reactive ({format(mean(
                  nhl[nhl$Ctry == input$Country, ]$HT), digits=4)})
          pick_avg_wt <-  reactive ({format(mean(
                  nhl[nhl$Ctry == input$Country, ]$Wt), digits=5)})
          pick_gpg <- reactive ({format(sum(nhl[nhl$Ctry == input$Country,]$G) / 
                  sum(nhl[nhl$Ctry == input$Country,]$GP),digits=3) })
#
# Calculate percentages
#                     
          goals_pct <- reactive ({format(pick_goals() / nhl_goals * 100,
                                         digits=4)})
          games_pct <- reactive ({format(pick_games() / nhl_games * 100,
                                         digits=4)})
          players_pct <- reactive ({format(pick_players() / nhl_players * 100,
                                         digits=4)})
#
# Render the output stats
#                     
          output$goals <- renderText({c(as.character(pick_goals()), " / ",
                                as.character(nhl_goals), " (",
                                as.character(goals_pct()), "%)")})
          output$games <- renderText({c(as.character(pick_games()), " / ",
                                        as.character(nhl_games), " (",
                                        as.character(games_pct()), "%)")})
          output$avg_age <- renderText({c(as.character(pick_avg_age()), 
                                          " yrs. old / ",
                                as.character(nhl_avg_age), " yrs. old")})
          output$avg_ht <- renderText({c(as.character(pick_avg_ht()), 
                                         " ins. / ",
                                as.character(nhl_avg_ht), " ins.")})
          output$avg_wt <- renderText({c(as.character(pick_avg_wt()), 
                                         " lbs. / ",
                                as.character(nhl_avg_wt), " lbs.")})
          output$gpg <- renderText({c(as.character(pick_gpg()), " / ",
                                as.character(nhl_gpg))})
          output$players <- renderText({c(as.character(players_pct()), "% (",
                                as.character(pick_players()), 
                                " of ", as.character(nhl_players),
 " players who appeared in at least one game) were born in the selected country")})
#
# Render the goal plot
#                     
          output$goals_plot <- renderPlot ({
                  par(bg = "darkolivegreen1")
                  bp <- barplot(chart_goals(), horiz=TRUE,
                  xlim = range(0,360),
                  col=c("blue","orange","gray"),
                  cex.names=0.7, las=2, border = NA,
                  main="Total Goals Scored By Draft Year",
                  xlab="Total Goals",
                  ylab="Draft Year")
          text(as.vector(chart_goals()), bp, as.vector(chart_goals()),
               cex=0.7, pos=4)          
          })
#
# Render the games plot
#                
          output$games_plot <- renderPlot ({
                  par(bg = "mistyrose")
                  bp2 <- barplot(chart_games(), horiz=TRUE,
                                xlim = range(0,3000),
                                col=c("blue","orange","gray"),
                                cex.names=0.7, las=2, border = NA,
                                main="Total Games Played By Draft Year",
                                xlab="Total Games",
                                ylab="Draft Year")
                  text(as.vector(chart_games()), bp2, as.vector(chart_games()),
                       cex=0.7, pos=4)          
          })
#
# Render text for about page
#
output$about <- renderText(c("This application has been developed by ",
 "github user gr1llman to ",
 "satisfy project requirements for 'Developing Data Products,' a course which is ",
 "offered by Johns Hopkins Bloomberg School of Public Health through"))
output$disclaim <- renderText(c("This application and the developer are in no ",
 "way affiliated with the NHL.  The developer does not own or claim any ",
 "rights to the data nor any patented or copyright material owned by the NHL. ",
 "The developer also cannot certify the accuracy of the information. ",
 "The data used was compiled and summarized in XLS format by Rob Vollman,  ",
 "(whom the developer has no relationship with) and is available at "))
output$using <- renderText(c("This application is very straight forward to ",
 "use.  Select a Country of Birth from the dropdown list and statistics ",
 "from the 2014-15 NHL season related to all NHL players born in that ",
 "country will be displayed."))
output$information <- renderText(c("The statistics provided by this ",
 "application should be familiar to hockey fans.   Basically, information ",
 "about goals scored and games played, as well as average personal ",
 "attributes (such as age, height and weight) are displayed and compared ",
 "to similar league wide statistics.  As well as numbers, there are two bar ",
 "charts provided.  One chart shows the total goals scored by players born ",
 "in the selected country, aggregated based on the year they were ",
 "drafted.  The second chart shows the total number of games played, also",
 "aggregagted based on year drafted. "))
        }
)