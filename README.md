# receptor-explorer
RxPlorer Shiny App

This is the repository for : https://danjoyce.shinyapps.io/receptorexplorer/

# About
This app aggregates data from public databases for ligand/receptor affinities and interactions.  The idea is to enable users to create their own versions of the familiar tables of medication-receptor affinities found in pharmacology textbooks and produce graphical representations.  The available searches (i.e. receptors) focus on psychotropic medications and collates data from the databases below.

For example, you can search and visualise data that answers questions such as 'What is the affinity and antagonism/agonism profile on DA1 through DA5 receptors for Olanzapine and Haloperidol ?'"

# Installation
To install a local copy, you'll need R, Shiny and to install the following packages:
`shiny`, `shinyWidgets`, `shinydashboard`, `dplyr`,`reshape2`,`ggplot2`,`scales`,`tippy`,`ggfittext`

# Code
In addition to the app code, there are some helper files:
 
  * `preprocess-ki-database.R` : with the CSV files for actions and affinities (see below) this produces a set of `.rds` files for the app to run (it's inefficient to use CSVs in the running app).  Can be used to update the content of the app in the future or local installations (download `KiDatabase.csv` and `interactions.csv` from the PDSP and IHUPHAR-BPS websites below and place in the `./Data/` directory).
  * `medication-lists.R` : common psychotropics used to test the application (for interest only)
  
# Acknowledgments
This app is only possible because of the generosity and efforts of:

  * The [UNC PDSP Ki Database](https://pdsp.unc.edu/databases/kidb.php) -- BL Roth, WK Kroeze, S Patel and E Lopez, The Multiplicity of Serotonin Receptors: Uselessly diverse molecules or an embarrasment of riches?, *"The Neuroscientist"*, 6:252-262, 2000 and Netwatch, *Science*, 28 January 2000; 287 (5453)
  
  * The [IUPHAR-BPS Databases](http://www.guidetopharmacology.org/) -- Armstrong JF, Faccenda E, Harding SD, Pawson AJ, Southan C, Sharman JL, Campo B, Cavanagh DR, Alexander SPH, Davenport AP, Spedding M, Davies JA; NC-IUPHAR. (2019) The IUPHAR/BPS Guide to PHARMACOLOGY in 2020: extending immunopharmacology content and introducing the IUPHAR/MMV Guide to MALARIA PHARMACOLOGY.*Nucl. Acids Res.*, pii: gkz951. doi: 10.1093/nar/gkz951

Both databases are freely available and for this current version, use the May 2020 versions.

In order to comply with the spirit and licensing of these publically-available databases, the code for this app is provided under a GPLv3 license which I understand to be compatible with the IUPHAR-BPS database which is distributed under the [Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)](https://creativecommons.org/licenses/by-sa/3.0/) licence

It was developed in [R](https://www.r-project.org/) and [Shiny](https://shiny.rstudio.com/).

This is not a funded project so while I have no plans to provide substantial changes or to add functionality please notify me if there are obvious errors or problems via the Contacts section [here](http://www.danwjoyce.com/contact)
