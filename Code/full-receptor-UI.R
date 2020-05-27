# "Full" flexible UI components and functions

FullReceptor.LayoutPanel <- function() {
  box(
    title = "Receptor Groups", width = 6, status = "info", collapsible = TRUE, solidHeader = TRUE,
    column(width = 12, align = "center", 
           splitLayout(
             cellWidths = c("20%", "12%", "12%", "20%", "12%", "17%" ),
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.Adren", label = NULL,
                                                direction = "vertical", size = "sm",
                                                choices = list("Adren. Alpha" = "adren.alpha.syn",
                                                               "Adren. Beta" = "adren.beta.syn",
                                                               "Noradren. Trans." = "adren.T.syn"
                                                ),
                                                selected = NULL),
             
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.Sero", label = NULL,
                                                direction = "vertical", size = "sm",
                                                choices = list("5HT-1" = "sero.1.syn",
                                                               "5HT-2" = "sero.2.syn",
                                                               "5HT-3" = "sero.3.syn",
                                                               "5HT-5" = "sero.5.syn",
                                                               "5HT-6" = "sero.6.syn",
                                                               "5HT-7" = "sero.7.syn",
                                                               "5HT-Trans" = "sero.T.syn"
                                                ),
                                                selected = NULL),
             
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.DA", label = NULL,
                                                direction = "vertical", size = "sm",
                                                choices = list("DA-1" = "dopa.1.syn",
                                                               "DA-2" = "dopa.2.syn",
                                                               "DA-3" = "dopa.3.syn",
                                                               "DA-4" = "dopa.4.syn",
                                                               "DA-5" = "dopa.5.syn",
                                                               "DA-Trans" = "dopa.T.syn"),
                                                selected = NULL),
             
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.Cholinergic", label = NULL,
                                                direction = "vertical", size = "sm",
                                                choices = list("ACh. Nicotinic" = "chol.nico.syn",
                                                               "ACh. Muscarinic" = "chol.musc.syn"),
                                                selected = NULL),
            
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.H", label = NULL,
                                                direction = "vertical", size = "sm",
                                                individual = TRUE,
                                                justified = TRUE,
                                                choices = list("Hist. 1-4" = "hist.syn"),
                                                selected = NULL),
           
             shinyWidgets::checkboxGroupButtons(inputId = "Receptor.Misc", label = NULL,
                                                direction = "vertical", size = "sm",
                                                individual = TRUE,
                                                justified = TRUE,
                                                choices = list("Misc. (HERG, IKr)" = "misc.syn"),
                                                selected = NULL)
           ) # close splitLayout   
    ) # close column
  ) # close box
}

FullReceptor.SelectMeds <- function(){
  box(
    title = "Select Medications", width = 3, status = "info", solidHeader = TRUE, collapsible = TRUE,
    selectInput(inputId = 'Medication.Selections', label = NULL,
                medication.list, multiple=TRUE, selectize=TRUE)
  )
}

FullReceptor.MiscControls <- function() {
  box(
    title = "Controls", width = 3, status = "info", solidHeader = TRUE, collapsible = TRUE,
    column( width = 12, align = "center",
        prettyRadioButtons(
          inputId = "CNS.Periph",
          label = "Show Affinities For:",
          choices = c("CNS", "Peripheral"),
          inline = TRUE,
          status = "info",
          fill = TRUE,
          selected = "CNS"),

        prettyCheckbox(
          inputId = "Show.Action",
          label = "Show Receptor Action", 
          status = "info",
          fill = TRUE,
          value = FALSE
        ),
        
        prettyRadioButtons(
          inputId = "Vis.Quantise",
          label = "Display pKi As:",
          choices = c("Continuous", "Quantised"),
          inline = TRUE,
          status = "info",
          fill = TRUE,
          selected = "Continuous"),
        
        tags$hr(style="border-color: grey;"),
        fluidRow(
          actionButton(inputId = "Go.Full.Filter", label = "Run Query", icon = icon("check-circle")),
          tippy_this("Go.Full.Filter", "Click here when you've selected medications and receptors")
        )
      )
  )
}

FullReceptor.Display <- function() {
          box(
              title = p("Profile",
                         downloadButton("Download.Graph", "", icon = icon("download"),
                                      class = "btn-xs", title = "Download")),
              width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE,
              column( width = 10, align = "center",
                imageOutput("Main.Plot", width = "100%", height = "600px")
              ),
              column( width = 2, align = "center",
                tableOutput("Action.Key")
              )
          )
}

FullReceptorSelection <- function() {
  fluidRow(
    FullReceptor.SelectMeds(),
    FullReceptor.LayoutPanel(),
    FullReceptor.MiscControls(),
    FullReceptor.Display()
  )
}

ReadMe <- function() {
  fluidRow(
      box(
        title = "About", status = "info", width = "full", solidHeader = TRUE, collapsible = FALSE,
        p("This app aggregates data from public databases for ligand/receptor affinities and interactions.  
           The idea is to enable users to create their own versions of the familiar tables of medication-receptor affinities found in pharmacology textbooks and produce graphical representations.
           The available searches (i.e. receptors) focus on psychotropic medications and collates data from the databases below."),
        p("For example, you can search and visualise data that answers questions such as ", tags$i("'What is the affinity and antagonism/agonism profile on DA1 through DA5 receptors for Olanzapine and Haloperidol ?'")),
        p("This app is only possible because of the generosity and efforts of:"),
        tags$ol(
            tags$li("The UNC ", a("PDSP Ki Database", href="https://pdsp.unc.edu/databases/kidb.php"), "-- BL Roth, WK Kroeze, S Patel and E Lopez, 
                    The Multiplicity of Serotonin Receptors: Uselessly diverse molecules or an embarrasment of riches?,", tags$i("The Neuroscientist"), "6:252-262, 2000 and 
                    Netwatch, ", tags$i("Science"), " 28 January 2000; 287 (5453)" ),
            tags$li("The ", a("IUPHAR-BPS Databases", href="http://www.guidetopharmacology.org/"), " -- Armstrong JF, Faccenda E, Harding SD, Pawson AJ, Southan C, Sharman JL, Campo B, Cavanagh DR, 
                    Alexander SPH, Davenport AP, Spedding M, Davies JA; 
                    NC-IUPHAR. (2019) The IUPHAR/BPS Guide to PHARMACOLOGY in 2020: extending immunopharmacology content and introducing the IUPHAR/MMV Guide to MALARIA PHARMACOLOGY. ",
                    tags$i("Nucl. Acids Res."), "pii: gkz951. doi: 10.1093/nar/gkz951", "; released under",
                    a("Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)", href = "https://creativecommons.org/licenses/by-sa/3.0/"), "licence.")
        ),
        p("Both databases are freely available and for this current version, use the May 2020 versions."),
        p("In order to comply with the spirit and licensing of these publically-available databases, the source code for this app is distributed using GPLv3."),
        p("It was developed in ", a("R", href = "https://www.r-project.org/"), " and ", a("Shiny", href = "https://shiny.rstudio.com/")),
        p("This is not a funded project so while I have no plans to provide substantial changes or to add functionality please notify me 
          if there are obvious errors or problems via the Contacts section ",
          a("here", href = "http://www.danwjoyce.com/contact"))
      )
  )
}

RetrieveFullReceptorSelection <- function( input.recept, this.list ) {
  if( length( input.recept ) > 0 ) {
    this.recept <- mget( input.recept, envir = .GlobalEnv ) 
    for( i in 1:length( this.recept ) ) {
      this.list <- c(this.list, this.recept[[i]])
    }
    return( this.list )
  } else {
    # just return the current list of receptors
    return( this.list )
  }
}


##################### Helper functions
ReadReceptorSelection <- function( input ) {
  
  recept.list <- list()
  
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.Adren, recept.list )
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.Sero, recept.list )
  
  
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.DA, recept.list )
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.H, recept.list )
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.Cholinergic, recept.list )
  recept.list <- RetrieveFullReceptorSelection( input$Receptor.Misc, recept.list )
  
  if( length( recept.list ) < 1 ) {
    # -- receptors not refined, so select "all"
    recept.list <- c(
      adren.alpha.syn, adren.beta.syn,
      sero.1.syn, sero.2.syn, sero.3.syn, sero.5.syn, sero.6.syn, sero.7.syn,
      dopa.1.syn, dopa.2.syn, dopa.3.syn, dopa.4.syn, dopa.5.syn, dopa.T.syn,
      hist.syn, chol.musc.syn, chol.nico.syn, misc.syn
    )
  }
  
  return( recept.list )
  
}


######################### Server-side processing for the "full" receptor interface 
GoFullFilter <- function( input, output, session ){
  current.selected.meds <<- input$Medication.Selections

  if( length( current.selected.meds ) > 0 ) {
    current.pki.subset <<- pki.db[ which( pki.db$Ligand %in% current.selected.meds ), ]
  }
  
  # -- which receptors
  current.selected.receptors <<- ReadReceptorSelection( input )
  
  # -- CNS or peripheral ?
  current.CNS.peripheral <<- input$CNS.Periph
  
  # -- do we have medications selected ? 
  if( is.null( current.selected.meds ) ) {
    # -- missing medications
    showModal(modalDialog(
      title = "Problem",
      "No medications selected",
      easyClose = TRUE
    ))
  } else {
    # retrieve receptor/medications affinities for both CNS and peripheral
    current.pki.matrix.CNS <<- CompileReceptorMedicationMatrix( "CNS" )
    current.pki.matrix.Periph <<- CompileReceptorMedicationMatrix( "Peripheral" )
    
    if( current.CNS.peripheral == "CNS" & input$Show.Action == TRUE ) {
      # retrieve the action-at-receptor table -- note, can only do this for CNS
      current.action.matrix <<- CompileReceptorActionMatrix()
      print( current.action.matrix )
    } else {
      current.action.matrix <<- NULL
    }
    
    this.plot <- ProduceHeatmap( m.cns = current.pki.matrix.CNS, 
                                 m.periph = current.pki.matrix.Periph, 
                                 m.action = current.action.matrix,
                                 quant = input$Vis.Quantise, 
                                 cns.switch = input$CNS.Periph )
    if( is.null( this.plot ) ) {
      showModal(modalDialog(
        title = "Problem",
        "No data available for the receptor/medication combinations selected",
        easyClose = TRUE
      ))
    } else {
      output$Main.Plot <- renderPlot(execOnResize = TRUE,{this.plot })
      if( input$Show.Action == TRUE ) {
        output$Action.Key <- renderTable( data.frame( Key = action.label, Action = names( action.label ) ), spacing = "s" )
      } else {
        output$Action.Key <- NULL
      }
    }
  }
}