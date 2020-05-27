# Receptor lists and synonyms (for both PKi and "actions" databases)

adren.alpha.syn <- list(
  "Adren. Alpha1" = c("adrenergic Alpha1","alpha1","alpha1-Adrenocepter"),
  "Adren. Alpha1A" = c("adrenergic Alpha1A", "alpha1A-adrenoceptor"),
  "Adren. Alpha1B" = c("adrenergic Alpha1B", "halpha1B-adrenergic", "alpha1B-adrenoceptor"),
  "Adren. Alpha1D" = c("adrenergic Alpha1D", "alpha1D-adrenoceptor"),
  "Adren. Alpha2"  = c("adrenergic Alpha2","alpha2-Adrenocepter","alpha2"),
  "Adren. Alpha2A" = c("adrenergic Alpha2A", "alpha2A-adrenoceptor"),
  "Adren. Alpha2B" = c("adrenergic Alpha2B", "alpha2B-adrenoceptor"),
  "Adren. Alpha2C" = c("adrenergic Alpha2C", "halpha2C-adrenergic", "alpha2C-adrenoceptor") )

adren.beta.syn <- list(
  "Adren. Beta"    = c("adrenergic Beta"),
  "Adren. Beta1"   = c("adrenergic Beta1", "beta1-adrenoceptor"),
  "Adren. Beta2"   = c("adrenergic Beta2", "beta2-adrenoceptor"),
  "Adren. Beta3"   = c("adrenergic Beta3", "beta3-adrenoceptor")
)

adren.T.syn <- list(
  "Noradr. Transporter" = c("Norepinephrine transporter")
)

# -- synonyms for serotonin : the name of the list element is the DISPLAY name we will use
#                             and the vectors c(...) are the synonyms in the actual database
sero.1.syn <- list(
  "5-HT1" = c("5-HT1"),
  "5-HT1A" = c("5-HT1A", "Serotonin 5-HT1A", "h5-HT1A", "5-HT1A receptor" ), 
  
  "5-HT1B" = c("5-HT1B", "5-HT1B receptor"),
  "5-HT1D" = c("5-HT1D", "5-HT1D receptor"),
  "5-HT1E" = c("5-HT1E", "5-ht1e receptor"),
  "5-HT1F" = c("5-HT1F", "5-HT1F receptor")
)

sero.2.syn <- list(
  "5-HT2"  = c("5-HT2"),
  "5-HT2A" = c("5-HT2A","Serotonin 5-HT2A","h5-HT2A", "5-HT2A receptor"),
  "5-HT2B" = c("5-HT2B","Serotonin 5-HT2B", "h5-HT2B", "5-HT2B receptor"),
  "5-HT2C" = c("5-HT2C","Serotonin 5-HT2C", "5-HT2C receptor"),
  "5-HT2C-INI" = c("5-HT2C-INI"),
  "5-HT2c-VGI" = c("5-HT2c VGI")
)

sero.3.syn <- list(
  "5-HT3" = c("5-HT3"),
  "5-HT3A" = c("5-HT3A"),
  "5-HT3AB" = c("5-HT3AB")
)

sero.5.syn <- list(
  "5-HT5A" = c("5-HT5A", "5-HT5a", "5-HT5A receptor")
)

sero.6.syn <- list(
  "5-HT6" = c("5-HT6", "5-HT6 receptor")
)

sero.7.syn <- list(
  "5-HT7" = c("5-HT7","Serotonin 5-HT7", "5-HT7 receptor"),
  "5-HT7A" = c("5-HT7L"),  # -- 5HT7-Long = 5HT7A
  "5-HT7B" = c("5-HT7b","5-HT7S") # -- 5HT7-SHort = 5HT7B
)

sero.T.syn <- list(
  "5-HT Transporter" = c("5-HT Transporter")
)

# -- D2A == Long  and D2B == Short equivalent
# -- D1A == D1 : https://www.ebi.ac.uk/QuickGO/term/GO:0031748

dopa.1.syn <- list(
  "D1" = c("D1","DOPAMINE D1", "Dopamine D1A", "D1A", "D1 receptor")
)

dopa.2.syn <- list( 
  "D2" = c("D2","DOPAMINE D2", "D2 receptor"),
  "D2-Long" = c("Dopamine D2A", "D2L","DOPAMINE D2 Long","DOPAMINE D2L", "hD2L" ),
  "D2-Short" = c("DOPAMINE D2 Short")
)

dopa.3.syn <- list(
  "D3" = c("D3", "DOPAMINE D3", "hD3", "D3 receptor")
)

dopa.4.syn <- list(
  "D4" = c("D4", "DOPAMINE D4", "D4 receptor"),
  "D4.2" = c("DOPAMINE D4.2" ),
  "D4.4" = c("D4.4","DOPAMINE D4.4")
)

dopa.5.syn <- list(
  "D5" = c("D5", "DOPAMINE D5", "D5 receptor")
)

dopa.T.syn <- list(
  "DA Transporter" = c("DAT","Dopamine Transporter")
)

hist.syn <- list(
  "H1" = c("H1", "HISTAMINE H1", "hH1", "H1 receptor"),
  "H2" = c("H2", "HISTAMINE H2", "H2 receptor"),
  "H3" = c("H3", "HISTAMINE H3", "H3 receptor"),
  "H4" = c("H4", "HISTAMINE H4", "H4 receptor")
)

# -- no synonyms for Cholinergic muscarinic receptors

chol.musc.syn <- list(
  "Chol. M"  = c("Cholinergic, muscarinic","Muscarinic"),
  "Chol. M1" = c("Cholinergic, muscarinic M1","Muscarinic M1","M1", "hM1", "M1 receptor"),
  "Chol. M2" = c("Cholinergic, muscarinic M2", "Muscarinic M2", "M2 receptor"),
  "Chol. M3" = c("Cholinergic, muscarinic M3", "M3 receptor"),
  "Chol. M4" = c("Cholinergic, muscarinic M4", "M4 receptor"),
  "Chol. M5" = c("Cholinergic, muscarinic M5", "M5 receptor")
)

# note, in the IUPHAR database, there are only specific alpha1 though 10 subunits, but not actual
# combinations that form e.g. neuronal receptors - (eg. the (a3)_2(b4)_3 CNS type)
# So we have to leave most of these out of the tool
# The CNS-type homomeric (a7)_5 is present so, we include
chol.nico.syn <- list(
  "Chol. N-Alpha1-Beta2" = c("Cholinergic, Nicotinic Alpha1Beta2"),
  "Chol. N-Alpha2-Beta4" = c("Cholinergic, Nicotinic Alpha2Beta4"),
  "Chol. N-Alpha7" = c("Cholinergic, Nicotinic Alpha7", "nicotinic acetylcholine receptor alpha7 subunit"),
  "Chol. N-Alpha6-Beta3-Beta4-Alpha5" = c("Cholinergic, Nicotinic Alpha6Beta3Beta4Alpha5"),
  "Chol. N-Alpha4-Beta4" = c("Cholinergic, Nicotinic Alpha4Beta4"),
  "Chol. N-Alpha4-Beta2" = c("Cholinergic, Nicotinic Alpha4Beta2**", "Cholinergic, Nicotinic Alpha4Beta2"),
  "Chol. N-Alpha2-Beta2" = c("Cholinergic, Nicotinic Alpha2Beta2"),
  "Chol. N-Alpha3-Beta2" = c("Cholinergic, Nicotinic Alpha3Beta2"),
  "Chol. N-Alpha3-Beta4" = c("Cholinergic, Nicotinic Alpha3Beta4","Cholinergic, Nicotinic Alpha3Beta4x"),
  "Chol. N-Alpha1-Beta1-Delta-Gamma" = c("Cholinergic, Nicotinic Alpha1Beta1DeltaGamma"),
  "Chol. N-Alpha6-Beta3-Beta4-Alpha5" = c("Cholinergic, Nicotinic Alpha6Beta3Beta4Alpha5")
)

# neither IKr or HERG are included in the IUPHAR database
misc.syn <- list(
  "HERG-IKr" = c("HERG", "IKr")
)
