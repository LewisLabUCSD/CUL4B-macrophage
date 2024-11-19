# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","value","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0010951","negative regulation of endopeptidase activity",0.240752211972651,3.76447155309245,0.694447108184506,0,"negative regulation of endopeptidase activity"),
c("GO:0032119","sequestering of zinc ion",0.000437858972069059,1.4197789392924,0.848721854055452,0.12230143,"negative regulation of endopeptidase activity"),
c("GO:1904237","positive regulation of substrate-dependent cell migration, cell attachment to substrate",0.00035937481669819,1.71664453220754,0.779818183235183,0.13827823,"negative regulation of endopeptidase activity"),
c("GO:0006897","endocytosis",0.271261894686821,1.33981391457162,0.981797266913174,0.14605446,"negative regulation of endopeptidase activity"),
c("GO:2000045","regulation of G1/S transition of mitotic cell cycle",0.0260402166030504,1.99321514305243,0.858474672602484,0.17974523,"negative regulation of endopeptidase activity"),
c("GO:0070372","regulation of ERK1 and ERK2 cascade",0.0467435106408818,1.61984193456964,0.788319127567461,0.18742237,"negative regulation of endopeptidase activity"),
c("GO:0051726","regulation of cell cycle",0.553742892846657,1.32073770627595,0.828464215712929,0.22869605,"negative regulation of endopeptidase activity"),
c("GO:0032930","positive regulation of superoxide anion generation",0.00179274333847143,1.07795005878701,0.795645095979071,0.32932095,"negative regulation of endopeptidase activity"),
c("GO:0002793","positive regulation of peptide secretion",0.0131894688473255,1.4197789392924,0.737942380287908,0.4568644,"negative regulation of endopeptidase activity"),
c("GO:1904706","negative regulation of vascular associated smooth muscle cell proliferation",0.00308566652958101,1.12703841185571,0.791316855057846,0.45989825,"negative regulation of endopeptidase activity"),
c("GO:0071635","negative regulation of transforming growth factor beta production",0.00164403651776873,1.54263711326053,0.806390403349142,0.47557449,"negative regulation of endopeptidase activity"),
c("GO:0010628","positive regulation of gene expression",0.269068469081456,1.37928001827917,0.741139332488968,0.50857087,"negative regulation of endopeptidase activity"),
c("GO:0071672","negative regulation of smooth muscle cell chemotaxis",0.00057004281269368,1.4197789392924,0.736969121377639,0.52154844,"negative regulation of endopeptidase activity"),
c("GO:0045454","cell redox homeostasis",0.18901463060317,1.41586146156387,0.811350546756727,0.54268686,"negative regulation of endopeptidase activity"),
c("GO:1902309","negative regulation of peptidyl-serine dephosphorylation",0.000582435047752239,1.54263711326053,0.77796847027926,0.57181851,"negative regulation of endopeptidase activity"),
c("GO:0048146","positive regulation of fibroblast proliferation",0.00727837272439322,1.0192785954651,0.780087580341021,0.58312432,"negative regulation of endopeptidase activity"),
c("GO:1901016","regulation of potassium ion transmembrane transporter activity",0.0174441362174305,1.24783897174007,0.774353179541602,0.60144276,"negative regulation of endopeptidase activity"),
c("GO:0043066","negative regulation of apoptotic process",0.158661916199741,1.88732213626375,0.719095484516736,0.60514539,"negative regulation of endopeptidase activity"),
c("GO:0046826","negative regulation of protein export from nucleus",0.00104920923495793,1.18296291006088,0.732949828514821,0.6355009,"negative regulation of endopeptidase activity"),
c("GO:0098609","cell-cell adhesion",0.22244888079116,8.95860731484177,0.972462275062102,0,"cell-cell adhesion"),
c("GO:0070488","neutrophil aggregation",0.000342851836620112,1.71664453220754,0.97488098454465,0.55136992,"cell-cell adhesion"),
c("GO:0033622","integrin activation",0.00153663714726123,1.18296291006088,0.97126288872107,0.00604659,"integrin activation"),
c("GO:0014002","astrocyte development",0.00395725372869961,3.34678748622466,0.95901082736067,0.00639868,"astrocyte development"),
c("GO:0032602","chemokine production",8.26149003903885E-06,1.54263711326053,0.954614299552892,0.2776994,"astrocyte development"),
c("GO:0030049","muscle filament sliding",0.000669180693162147,2.23617190321891,0.919605880317592,0.33303841,"astrocyte development"),
c("GO:0001816","cytokine production",0.00283369108339032,1.61984193456964,0.944024305439834,0.35636193,"astrocyte development"),
c("GO:0007015","actin filament organization",0.206124176474019,1.48956658228992,0.931751491302463,0.61367837,"astrocyte development"),
c("GO:0051085","chaperone cofactor-dependent protein refolding",0.0194021093566827,1.32494621122777,0.99365542449536,0.00709279,"chaperone cofactor-dependent protein refolding"),
c("GO:0008283","cell population proliferation",0.0973451371299947,2.528609187939,0.99293532364152,0.00796989,"cell population proliferation"),
c("GO:0098869","cellular oxidant detoxification",0.889828569124796,4.23732143627256,0.891039035898922,0.00959826,"cellular oxidant detoxification"),
c("GO:0070911","global genome nucleotide-excision repair",0.00064026547802551,1.42046785163584,0.90386083437512,0.23243185,"cellular oxidant detoxification"),
c("GO:0009615","response to virus",0.167819777908016,1.04382044649183,0.928772868283176,0.31351001,"cellular oxidant detoxification"),
c("GO:0007229","integrin-mediated signaling pathway",0.085824489270555,1.15000956052019,0.783258017477787,0.32905741,"cellular oxidant detoxification"),
c("GO:0006979","response to oxidative stress",0.582480485947453,1.04382044649183,0.903781452600197,0.35304712,"cellular oxidant detoxification"),
c("GO:0007165","signal transduction",7.31364928685992,1.0229112427743,0.703866335640113,0.52841124,"cellular oxidant detoxification"),
c("GO:0000302","response to reactive oxygen species",0.161747582729322,2.20445724790796,0.89152699697741,0.58011608,"cellular oxidant detoxification"),
c("GO:0042542","response to hydrogen peroxide",0.0226282212169274,1.06143037395224,0.90305565214508,0.69707352,"cellular oxidant detoxification"),
c("GO:0006915","apoptotic process",0.224266408599748,1.6633224538515,0.992494729840185,0.00960548,"apoptotic process"),
c("GO:0000413","protein peptidyl-prolyl isomerization",0.429531390109708,2.08618106512948,0.953722202571362,0.01021914,"protein peptidyl-prolyl isomerization"),
c("GO:0006749","glutathione metabolic process",0.471739342719157,1.77414860124672,0.952334973403432,0.1403038,"protein peptidyl-prolyl isomerization"),
c("GO:0030091","protein repair",0.0755430649169712,1.24783897174007,0.958126824017204,0.25164961,"protein peptidyl-prolyl isomerization"),
c("GO:0006413","translational initiation",0.515768953882215,1.35897030755148,0.928693887052816,0.49676178,"protein peptidyl-prolyl isomerization"),
c("GO:0006928","movement of cell or subcellular component",0.96156308713377,2.83603259837793,0.991582136817675,0.01109838,"movement of cell or subcellular component"),
c("GO:0006457","protein folding",0.934345608200157,2.73728319765249,0.991602187714908,0.01115653,"protein folding"),
c("GO:0009438","methylglyoxal metabolic process",0.0353178699168911,1.71664453220754,0.977919823748195,0.04775374,"methylglyoxal metabolic process"),
c("GO:0015949","nucleobase-containing small molecule interconversion",0.000627873242966952,1.61984193456964,0.97187244155448,0.15474465,"methylglyoxal metabolic process"),
c("GO:0006914","autophagy",0.233597761598843,2.02733176844323,0.980866892343201,0.05559218,"autophagy"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="../results/REVIGO/revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  stuff,
  index = c("representative","description"),
  vSize = "value",
  type = "categorical",
  vColor = "representative",
  title = "Revigo TreeMap",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
								 # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none"
)

dev.off()

