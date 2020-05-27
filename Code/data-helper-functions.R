# helper functions for processing data

## -- For post-processing the pki.db data once receptors and medications selected

############
# for the "actions" we define the following abbreviations
action.label <- c(
  "Antagonist" = "(--)", 
  
  "Full agonist" = "(+++)", 
  "Agonist" = "(++)", 
  "Partial agonist" = "(+)", 
  "Inverse agonist" = "-(+)", 
  
  "Biased agonist" = "B(+)",
  "Irreversible agonist" = "Irr(+)", 
  
  "Inhibition" = "Inh", 
  "None" = "None", 
  
  "Binding" = "Bind", 
  "Activation" = "Act", 
  "Negative" = "Neg", 
  "Positive" = "Pos",
  

  "Pore blocker" = "PB", 
  "Irreversible inhibition" ="IrrInh",
  "Slows inactivation" = "SA", 
  "Competitive" = "Comp", 
  "Potentiation" = "Pot", 
  "Neutral" = "Neu", 
  "Unknown" = "Unk", 
  
  "Non-competitive" = "NComp", 
  "Feedback inhibition" = "FInh", 
  "Voltage-dependent inhibition" = "VInh", 
  
  "Mixed" = "Mix", 
  "Biphasic" = "Biph"    
)

CompileReceptorMedicationMatrix <- function( cns.periph ) {
# Takes the current.selected.receptors and current.selected.meds and compiles 
# a matrix [receptor x meds] matrix by aggregating over synonyms
# For example, for D1, takes the median of "D1","DOPAMINE D1", "Dopamine D1A", "D1A"
# pKis and creates a row for D1 for each medication
# Yields NA when for a receptor / med combination has no data

  ## 1 : extract medications and receptors from global state variables
  all.recept <- unlist(current.selected.receptors, use.names = FALSE)
  all.meds   <- current.selected.meds
  
  ## 2 : subset the receptors, medications and CNS vs Peripheral
  pki.db.subset <- pki.db[ which( pki.db$Ligand %in% all.meds ), ]
  pki.db.subset <- pki.db.subset[ which( pki.db.subset$Receptor %in% all.recept ), ]
  pki.db.subset <- pki.db.subset[ which( pki.db.subset$Source == cns.periph ), ]
  
  ## 3 : aggregate by the receptor synonyms in current.selected.receptors
  pki.m <- matrix( NA, nrow = length( names( current.selected.receptors ) ), ncol = length( all.meds ) )
  colnames(pki.m) <- all.meds
  rownames(pki.m) <- names( current.selected.receptors )
  
  for( i in 1:nrow( pki.m ) ) {
    this.recept <- rownames( pki.m )[i] 
    this.recept.group <- current.selected.receptors[[ this.recept ]]
    for( j in 1:ncol( pki.m ) ) {
      this.med <- colnames( pki.m )[j]
      this.pki <- pki.db.subset$pKi[ which( pki.db.subset$Receptor %in% this.recept.group 
                                            & pki.db.subset$Ligand == this.med ) ]
      
      # any values for this med / receptor combination ?
      if( length( this.pki ) > 0 ) {
        avrg.pki <- median( this.pki )
      } else {
        avrg.pki <- NA
      }
      
      pki.m[i,j] <- avrg.pki
    }
  }
  return( pki.m )
}

CompileReceptorActionMatrix <- function() {
  all.recept <- unlist(current.selected.receptors, use.names = FALSE)
  all.meds   <- current.selected.meds
  
  ## 2 : subset the receptors, medications
  action.db.subset <- action.db[ which( action.db$Ligand %in% all.meds ), ]
  action.db.subset <- action.db.subset[ which( action.db.subset$Receptor %in% all.recept ), ]
  
  ## 3 : add abbreviation for action
  action.db.subset$Abbrev <- action.label[ action.db.subset$Action ]
  
  # Should not be any duplicates as removed non-human species
  # but remove duplicates (because IUPHAR has duplic for pKi and other data NOT related to action)
  
  dup.rows <- which( duplicated( action.db.subset ) )
  if( length( dup.rows > 0 ) ) {
    action.db.subset <- action.db.subset[ -which( duplicated( action.db.subset ) ), ]
  }
  
  ## 4: aggregate by the receptor synonyms in current.selected.receptors
  action.m <- matrix( NA, nrow = length( names( current.selected.receptors ) ), ncol = length( all.meds ) )
  colnames(action.m) <- all.meds
  rownames(action.m) <- names( current.selected.receptors )
  
  for( i in 1:nrow( action.m ) ) {
    this.recept <- rownames( action.m )[i] 
    this.recept.group <- current.selected.receptors[[ this.recept ]]
    for( j in 1:ncol( action.m ) ) {
      this.med <- colnames( action.m )[j]
      
      # retrieve temp table for this med and receptor
      temp.action <- action.db.subset[ which( action.db.subset$Receptor %in% this.recept.group 
                                              & action.db.subset$Ligand == this.med ), ]
      
      if( nrow( temp.action ) > 1 ) {
        # there remains more than ONE action, this indicates a conflict which can be resolved by chosing the "primary target"
        this.action <- temp.action$Abbrev[ which( temp.action$Primary.Target == "t") ] 
      } else {
        this.action <- temp.action$Abbrev
      }
  
      # any values for this med / receptor combination ?
      if( length( this.action ) > 0 ) {
        action.lbl <- this.action
      } else {
        action.lbl <- NA
      }
      
      action.m[i,j] <- action.lbl
    }
  }
  return( action.m )
}