# constants, lists / data structures to assist

################################################
# Drug lists 
ANTIPSY <- c("CLOZAPINE","LOXAPINE","OLANZAPINE",
                    "SERTINDOLE","ARIPIPRAZOLE","QUETIAPINE", 
                    "LURASIDONE", "RISPERIDONE", "MELPERONE", 
                    "ZIPRASIDONE", "HALOPERIDOL", "TRIFLUOPERAZINE",
                    "CHLORPROMAZINE", "FLUPENTHIXOL, ALPHA", "SULPIRIDE", 
                    "AMISULPRIDE", "LEVOMEPROMAZINE", "PERPHENAZINE", 
                    "PIMOZIDE", "ILOPERIDONE"
)


SSRI <- list(CITALOPRAM = c("CITALOPRAM"),
             ESCITALOPRAM = c("ESCITALOPRAM", "R-CITALOPRAM"),
             FLUOXETINE = c("FLUOXETINE","FLUOXETINE-R-(-)"),
             FLUVOXAMINE = c("FLUVOXAMINE"),
             PAROXETINE = c("PAROXETINE"),
             SERTRALINE = c("SERTRALINE")
)


SNRI <- list( 
  ATOMOXETINE = c("ATOMOXETINE"),
  DULOXETINE = c("DULOXETINE"),  
  # "LEVOMILNACIPRAN" -- no data
  MILNACIPRAN = c("MILNACIPRAN"),
  SIBUTRAMINE = c("SIBUTRAMINE"),
  VENLAFAXINE = c("VENLAFAXINE", "O-DESMETHYLVENLAFAXINE")
)


# -- non-selective monamineoxidase inhibitors
MAOI.AB <- list(
  # no data : "ISOCARBOXAZID"   
  # no data : HYDRAZINE
  # no data : "NIALAMIDE"
  PHENELZINE = c("PHENELZINE"),
  # no data : "HYDRACARBAZINE"  
  TRANYLCYPROMINE = c("TRANYLCYPROMINE")
)

MAOI.A <- list(
  # no data : "BIFEMELANE"  
  # no data : "MOCLOBEMIDE" 
  # no data  "PIRLINDOLE"  
  # no data :"TOLOXATONE" 
)

# Selective MAO-B inhibitors
MAOI.B <- list(
  # no data : "RASAGILINE" 
  # no data :"SELEGILINE" 
  # no data "SAFINAMIDE"
)

# TCA
TCA <- list(
  AMITRIPTYLINE = c("AMITRIPTYLINE"),
  AMOXAPINE = c("AMOXAPINE"), # -- only one metabolite, so not differentiated
  CLOMIPRAMINE = c("CLOMIPRAMINE"),
  DESIPRAMINE = c("DESIPRAMINE","DESMETHYLDESIPRAMINE"), # - metabolite DESMETHYL DESIPRAMINE is well studied so included
  DOXEPIN = c("DOXEPIN", "DOXEPINE"),
  IMIPRAMINE = c("IMIPRAMINE"),
  TRIMIPRAMINE = c("TRIMIPRAMINE"),
  MAPROTILINE = c("MAPROTILINE"),
  NORTRYPTYLINE = c("NORTRYPTYLINE"),
  PROTRIPTYLINE = c("PROTRIPTYLINE")
)

MISC <- list(
  BUPROPION = c("BUPROPION"),
  BUSPIRONE = c("BUSPIRONE"),
  MAPROTILINE = c("MAPROTILINE"),
  MIRTAZAPINE = c("MIRTAZAPINE"),
  REBOXETINE = c("REBOXETINE"),
  TRAZODONE = c("TRAZODONE")
  # no data : "VILAZODONE" 
)
