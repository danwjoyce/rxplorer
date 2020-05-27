rm( list = ls() )
library(shiny)
library(shinyWidgets)
library(shinydashboard)
library( dplyr )
library( reshape2 )
library( ggplot2 )
library( scales )
library( tippy )
library( ggfittext )

# -- this suppresses non UTF character error warnings
Sys.setlocale('LC_ALL','C') 

# -- Load databases
data.path <- "./Data/"
code.path <- "./Code/"
pki.fName <- "ki-database.rds"
action.fName <- "action-database.rds"
pki.db <<- readRDS( paste0(data.path, pki.fName))
action.db <<- readRDS( paste0(data.path, action.fName))

# -- Load lists of common psychotropic medications / synonyms for receptors
source( paste0( code.path, "receptor-lists.R" ) ) ## CHECKED
source( paste0( code.path, "data-helper-functions.R" ) ) ## CHECKED
source( paste0( code.path, "visualisation-helper-functions.R" ) ) ## CHECKED
source( paste0( code.path, "full-receptor-UI.R"))  ## CHECKED

# Version number/history
  # 0.1 - 30th June 2019 : first prototype with functioning graphs, not fully debugged (doesn't catch 'no data' errors)
  # 0.2 - 4th July 2019 : added lurasidone, brexpiprazole and asenapine from literature (rather than UNC pki DB)
  # 0.3 - 10th July 2019 : changed to dashboard (so "simplified" view can be added later); added IUPHAR receptor actions for CNS receptors
  # 0.4 - 14th July 2019 : corrected receptor plot to use base_size for fonts and to scale the download image to be readable.
  # 0.5 - 25th May 2020 : first release version; removed simplified view : just no time to work on it !

  app.version.number <- 0.5

# -- globals to speed up the UI a little
medication.list <<- unique( pki.db$Ligand )

# -- some application state globals
current.selected.meds <<- NULL
current.selected.receptors <<- NULL
current.CNS.peripheral <<- NULL
# -- global data for plotting
current.pki.matrix.CNS <<- NULL
current.pki.matrix.Periph <<- NULL
current.action.matrix <<- NULL

ui <- dashboardPage(skin = "purple",
  dashboardHeader(title = paste0("RxPlorer v", app.version.number)),
  dashboardSidebar(
    width = 150, 
    sidebarMenu(
         menuItem("Full View", tabName = "full-receptor-view", icon = icon('th') ),
         menuItem("About", tabName = "read-me", icon = icon('glasses') )
      )
    ),

  dashboardBody(
    tabItems( 
      tabItem(tabName = "full-receptor-view",
              FullReceptorSelection()
      ),
      tabItem(tabName = "read-me",
              ReadMe()
      )
    )
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$Go.Full.Filter, {
    GoFullFilter( input, output, session )
  })

  output$Download.Graph = downloadHandler(
    filename = 'receptor-plot.png',
    content = function(file) {
      device <- function(..., width, height) {
        grDevices::png(..., width = width, height = height,
                       res = 300, units = "in")
      }
      ggsave(file, plot = ProduceHeatmap( m.cns = current.pki.matrix.CNS, 
                                          m.periph = current.pki.matrix.Periph, 
                                          m.action = current.action.matrix,
                                          quant = input$Vis.Quantise, 
                                          cns.switch = input$CNS.Periph ), device = device(width = 12, height = 6))
    })

  
}

# Run the application 
shinyApp(ui = ui, server = server)

