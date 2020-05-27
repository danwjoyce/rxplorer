# Pre-process ki database for deployment in a Shiny app
# Note, this is only required if rebuilding the databases is required (e.g. if data is downloaded from the sites below)

# Source data :
# Affinity data from :
# -- https://pdsp.unc.edu/databases/kidb.php
# -- Data is downloaded wholesale as CSV from : https://pdsp.unc.edu/databases/kiDownload/

# Action at receptor data from ligand/receptor interactions database at
# # http://www.guidetopharmacology.org/DATA/file_descriptions.txt 
# # the "interactions" database (ligand/receptor) is from here : https://www.guidetopharmacology.org/download.jsp#database




rm( list = ls() )
require( dplyr )
require( stringr )

# -- note relative path
data.path <- "./Data/"
# -- insert name of CSV downlaoded here ...
dbFileName <- "KiDatabase.csv"

# -- this suppresses non UTF character error warnings
Sys.setlocale('LC_ALL','C') 

# -- load entire db
D <- read.csv( paste0( data.path, dbFileName ), stringsAsFactors = TRUE )

# -- First filter :
# -- select relevant columns and select only HUMAN species
D <- D %>% select( Name, Ligand.Name, species, ki.Val, source  ) %>%  filter( species == "HUMAN")

# -- convert ligand names to uppercase for ease of searching 
D$Ligand.Name <- toupper(D$Ligand.Name)

# -- Second filter : acceptable tissue targets
# -- set up CNS targets strings but also include "CLONED" 
CNS.str <- c(
  "AMYGDALA", "ANTERIOR PITUITARY", "AREA POSTREMA",                            
  "BRAIN", "BRAIN CORTEX", "BRAINSTEM", "Brain Frontal Cortex", "Brain caudate nucleus",
  "CAUDATE", "CAUDATE NUCLEUS", "CEREBELLUM", "CEREBRAL CORTEX", "CORTEX", "CORTICAL", "CORTICAL MEMBRANES",
  "Cerebellum/Brain", "Colliculus Neurons", "Corpus Striatum", "ENTO CORTEX", "FOREBRAIN", "FR. CORTEX", 
  "HIPPO:LESIONED", "HIPPOCAMPUS", "HIPPOCAMPUS CA1", "HIPPOCAMPUS CA3", "HIPPOCAMPUS DG", 
  "HYPOTHALAMUS", "Hindbrain", "Hippocampal", "Hypophysis", "Inferior Colliculus", "Interpeduncular n.",                            
  "Medulla oblongata", "Midbrain", "N. Accumbens", "Nucleus accumbens",
  "Olfactory bulbs", "P.Entorhinal cortex", "Pineal", "Pituitary", "Pre-frontal Cortex", 
  "Putamen", "S. Nigra", "STRIATUM", "Striatal", "Superior Colliculus", "Temp. Cortex",
  "Total Cortex", "WHOLE BRAIN", "WHOLE BRAIN MINUS  CEREBELLUM", "WHOLE BRAIN MINUS CEREBELLUM MINUS CORTEX",
  "limbic forebrain", "medulla, pons", "olfactory tubercle", "parietal cortex", "superior cervical ganglia",
  "telencephalic membranes", "thalamus", "CLONED"
)

CodeCNS <- function( q ) {
  ifelse( q %in% CNS.str, "CNS", "Peripheral" )
}

# -- convert to ki to pKi
D$pKi <- -log10( D$ki.Val * 10^(-9) )

# -- code the "source" column as CNS or peripheral : if in the CNS.str list above, code CNS, else Peripheral
D$source <- CodeCNS( D$source )

# -- drop irrelevant columns
keep.cols <- c("Name","Ligand.Name","source","pKi")
D <- D[ , which( names(D) %in% keep.cols ) ]
names( D ) <- c("Receptor","Ligand","Source","pKi")

# -- keep only Ligands which start with an alphanumeric (A through Z) to slim down some of the more obscure compounds
#    Net result is that we lose some compounds identfied by compound names e.g. ((3S,6S)-1-(4-CHLOROPHENYL)-6-(2,4-DICHLOROPHENYL)PIPERIDIN-3-YL)METHANAMINE
#    but this should not be a problem for this application
D <- D[ grep( "^[A-Z]", D$Ligand ), ]

# -- sort by Ligand order
D <- D[ order( D$Ligand ), ]

# -- add in some other antipsychotic class meds not in (or incomplete)  NC pki database at the time of writing

  # - for Asenapine : Shahid, M., Walker, G. B., Zorn, S. H., & Wong, E. H. F. (2009). Asenapine: a novel psychopharmacologic agent with a unique human receptor signature. Journal of psychopharmacology, 23(1), 65-73
  load( paste0( data.path, "asenapine_table.RData") )
  # -- asenapine in pKi already
    asen.df <- data.frame(Receptor = rownames( asen.m ),
                          Ligand = "ASENAPINE",
                          Source = "CNS",
                          pKi = as.numeric( asen.m[,1] ) )
  
  # -- for addtional brexipiprazole pKis : Maeda, K., Sugino, H., Akazawa, H., Amada, N., Shimada, J., Futamura, T., ... & Pehrson, A. L. (2014). Brexpiprazole I: in vitro and in vivo characterization of a novel serotonin-dopamine activity modulator. Journal of Pharmacology and Experimental Therapeutics, 350(3), 589-604
  brexpip <- read.csv( paste0( data.path, "brexpiprazole_ki.csv") )
    brexpip.df <- data.frame(Receptor = brexpip$Name,
                             Ligand = "BREXPIPRAZOLE",
                             Source = "CNS",
                             pKi = -log10( brexpip$ki.Val * 10^(-9) ) )
  
  # for lurasidone : Ishibashi T, et al (2010). Pharmacological profile of lurasidone, a novel antipsychotic agent with potent 5-hydroxytryptamine 7 (5-HT7) and 5-HT1A receptor activity". J. Pharmacol. Exp. Ther. 334 (1): 171–81
  lurasidone <- read.csv( paste0( data.path, "lurasidone_ki.csv" ) )
    lurasidone.df <- data.frame(Receptor = lurasidone$Name,
                                Ligand = "LURASIDONE",
                                Source = "CNS",
                                pKi = -log10( lurasidone$ki.Val * 10^(-9) ) )
    
  # bind together with main pki database
  D <- do.call( "rbind", list(D, asen.df, brexpip.df, lurasidone.df ) )
    
# -- write out a serialised R binary version for re-use
saveRDS( D, file = paste0(data.path, "ki-database.rds") )


################## for ligand/receptor interactions
# A <- read.csv( paste0( data.path, "interactions.csv" ), stringsAsFactors = FALSE )
A <- read.csv( paste0( data.path, "interactions.csv" ), stringsAsFactors = FALSE )
A$ligand <- toupper( A$ligand )

# -- retain only Human target_species
A <- A[ which( A$target_species == "Human" ), ]

# -- retain : "target" receptor, "ligand" (medication) and "action" (agonist, partial agonist, full agonist etc.) - this is more detailed than
#             the "type" column
keep.cols <- c("target", "ligand", "action", "primary_target" )

A <- A[ , which( names( A ) %in% keep.cols ) ]

# filter out obscure compounds which are unlikely to be medication compound names e.g. COMPOUND 34 [PMID: 20866075]
A <- A[ grep( "^[A-Z]", A$ligand ), ]

# -- sort by Ligand order
A <- A[ order( A$ligand ), ]

# remove UTF and HTML codes
A$target <- gsub("<sub>", "", A$target, ignore.case = TRUE )
A$target <- gsub("</sub>", "", A$target, ignore.case = TRUE )

A$target <- gsub("<sup>", "", A$target, ignore.case = TRUE )
A$target <- gsub("</sup>", "", A$target, ignore.case = TRUE )

A$target <- gsub(";", "", A$target )
A$target <- gsub("&", "", A$target )
A$target <- gsub("/&", "", A$target )
A$target <- gsub("<i>", "", A$target, ignore.case = TRUE )
A$target <- gsub("</i>", "", A$target, ignore.case = TRUE )

# make naming compatible
names( A ) <- c("Receptor","Ligand","Action", "Primary.Target")


saveRDS( A, file = paste0( data.path, "action-database.rds") )





