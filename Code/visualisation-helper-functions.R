# Visualisating helper functions for RxPlorer app

# -- Some functions to quantise the pKi values into useful ranges and 
#    nomenclature commonly used in the literature : i.e. "high" "very high", "low"
# -- quantised receptor affinities
# -- from Morrison et al Advanced Prescribing in Psychosis

# Affinity: ++++ Very High (< 1nm); +++ High (1 - 10nM); ++ Moderate (10 – 100nM); + Low (100 – 1000nM); 0 non-significant (>1000nM).

quant.pki <- c(1, 10, 100, 1000)
quant.pki <- -log10( quant.pki * 10^(-9) )
quant.pki <- quant.pki[ order( quant.pki) ]
quant.pki.label <- c("Insignificant","Low","Moderate","High","Very High")

pki.quantise <- function( x ) {
  # -- return a quantised version of a vector real-valued pKis
  return( findInterval(x, quant.pki) + 1 )
}

pki.label <- function( x ) {
  # -- wraps pki.quantise, instead returning factor representation
  return( 
    factor( quant.pki.label[ pki.quantise(x) ], levels = quant.pki.label, ordered = TRUE )
  )
}

# -- so, if pKi > 9       = very high   ( ==  < 1 nM)
#           9 >= pKi > 8  = high        ( ==  between 1 - 10 nM)
#           8 >= pKi > 7  = Moderate    ( ==  between 10 - 100 nM)
#           7 >= pKi > 6  = low         ( ==  between 100 - 1000 nM)
#           6 >= pKi      = very low    ( ==  greater than 1000 nM )

# # -- e.g. :
# x <- c(0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.6, 10, 11)
# pki.label( x )


quantHeatmap <- function( m, m.action = NULL ) {
  # -- takes a regular matrix of receptor x medication and quantises before producing a heatmap 
  
  # # colour blind friendly  
  color.vals = c("Insignificant" = '#2c7bb6', "Low" = '#abd9e9', "Moderate" = '#ffffbf', 
                 "High" = '#fdae61', "Very High" = '#d7191c') 
  
  m.long <- melt(m)
  colnames(m.long) <- c("Receptor", "Medication", "pKi")

  m.long$pKi <- pki.label( m.long$pKi )
  
  # user wants action at receptor plotted too
  if( !is.null( m.action ) ){
    m.action.long <- melt( m.action )
    colnames(m.action.long) <- c("Receptor", "Medication", "Action")
    m.long <- dplyr::left_join( m.long, m.action.long )
  } else {
    m.long$Action <- NA
  }
  
  p <- ggplot(m.long,
              aes(x = Receptor, y = Medication, fill = pKi ) ) +
    geom_tile() +
    coord_fixed() +
    # add in action labels, if present
    geom_fit_text(aes(x = Receptor, y = Medication, label = factor(Action) ), reflow = TRUE, grow = TRUE) +
    theme_minimal(base_size = 14) +
    theme(
      axis.text.x = element_text(
        angle = 45,
        hjust = 1,
        size = 14
      ),
      axis.text.y = element_text(
        angle = 45,
        hjust = 1,
        size = 12
      ),

      legend.position = "top",

      panel.grid.major = element_blank(), panel.grid.minor = element_blank()
    ) +
    xlab("") + ylab("") +
    scale_fill_manual(
      values = color.vals,
      name = "",
      na.value = '#ffffff',
      na.translate = FALSE,
      drop = FALSE,
      guide = guide_legend(reverse = FALSE)
    )
  return( p )
}

contHeatmap <- function( m, m.action = NULL ) {
  
  # -- takes a regular matrix of receptor x medication and quantises before producing a heatmap 
  #    with continuous color-blind friendly values
  
  # NB : the 'traditional' quantised ranges for receptor affinity are
  # -- so, if pKi > 9       = very high   ( ==  < 1 nM)
  #           9 >= pKi > 8  = high        ( ==  between 1 - 10 nM)
  #           8 >= pKi > 7  = Moderate    ( ==  between 10 - 100 nM)
  #           7 >= pKi > 6  = low         ( ==  between 100 - 1000 nM)
  #           6 >= pKi      = very low    ( ==  greater than 1000 nM )
  
  # but for the continuous heatmap, we have to decide on the midrange, lower and upper
  # values.  So, we'll set the lowest value to be 6, the midrange to be 7.5 and the highest to by 9
  
  # colour blind friendly  
  color.vals <- 
    rev(c('#d7191c','#fdae61','#ffffbf','#abd9e9','#2c7bb6'))
  
  
  m.long <- melt(m)
  colnames(m.long) <- c("Receptor", "Medication", "pKi")
  
  # user wants action at receptor plotted too
  if( !is.null( m.action ) ){
    m.action.long <- melt( m.action )
    colnames(m.action.long) <- c("Receptor", "Medication", "Action")
    m.long <- dplyr::left_join( m.long, m.action.long )
  } else {
    m.long$Action <- NA
  }
  
  p <- ggplot(m.long,
              aes(x = Receptor, y = Medication, fill = pKi ) ) +
    geom_tile() +
    coord_fixed() +
    geom_fit_text(aes(x = Receptor, y = Medication, label = factor(Action) ), reflow = TRUE, grow = TRUE) +
    theme_minimal(base_size = 14) +
    theme(
      axis.text.x = element_text(
        angle = 45,
        hjust = 1
        #size = 14
      ),
      axis.text.y = element_text(
        angle = 45,
        hjust = 1
        #size = 12
      ),

      legend.position = "top",

      legend.justification = "center",
      panel.grid.major = element_blank(), panel.grid.minor = element_blank()
    ) + 
    xlab("") + ylab("") +
    scale_fill_gradientn(name = "pKi",
                         colours = color.vals,
                         values = rescale( quant.pki, to = c(0,1) ),
                         breaks = quant.pki,
                         oob = scales::squish,
                         na.value = "white",
                         limits = c(quant.pki[1], high = quant.pki[4]),
                         guide = guide_colourbar(
                           title = "pKi",
                           title.position = "left",
                           title.vjust = 0.75,
                           direction = "horizontal",
                           barwidth = 8,
                           label.position = "bottom"
                         ),
                         aesthetics = "fill")
  return( p )
}

ProduceHeatmap <- function( m.cns, m.periph, m.action = NULL, quant, cns.switch ) {
  # switch for peripheral vs CNS ?
  if( cns.switch == "CNS" ) {
    m <- m.cns
  } else {
    m <- m.periph
  }

  if( all( is.na( m ) ) ) {
    # this receptor/medication combination has no data, so return NULL
    return( NULL )
  } else {
    if( quant == "Quantised" ) {
      return( quantHeatmap( m, m.action ) )
    } else {
      return( contHeatmap( m, m.action ) )
    }
  }
}

