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
revigo.data <- rbind(c("GO:0006888","endoplasmic reticulum to Golgi vesicle-mediated transport",0.166022903824525,3.56066730616974,0.89806204998837,0,"endoplasmic reticulum to Golgi vesicle-mediated transport"),
c("GO:0016192","vesicle-mediated transport",1.40900125690309,2.28339601978104,0.952275905331163,0.25935534,"endoplasmic reticulum to Golgi vesicle-mediated transport"),
c("GO:0007568","aging",0.0391388090599465,1.53257400334006,0.979667268228558,0,"aging"),
c("GO:0021762","substantia nigra development",0.000326328856542034,1.03415291993752,0.964985276029335,0.37402369,"aging"),
c("GO:0045071","negative regulation of viral genome replication",0.00667528395154339,5.47366072261016,0.836288105349633,0,"negative regulation of viral genome replication"),
c("GO:0043488","regulation of mRNA stability",0.10022013566358,3.13727247168203,0.803691314787647,0.1460937,"negative regulation of viral genome replication"),
c("GO:1903076","regulation of protein localization to plasma membrane",0.0215377045317743,1.09468634261453,0.868451448699106,0.16725876,"negative regulation of viral genome replication"),
c("GO:0090263","positive regulation of canonical Wnt signaling pathway",0.0258873790373282,2.07318259704492,0.753385412673701,0.16928763,"negative regulation of viral genome replication"),
c("GO:0006521","regulation of cellular amino acid metabolic process",0.0152300568869681,1.79396692394829,0.849265111829581,0.23271804,"negative regulation of viral genome replication"),
c("GO:0060700","regulation of ribonuclease activity",0.00495276327840379,1.68329046143565,0.846299038813674,0.24365552,"negative regulation of viral genome replication"),
c("GO:0032480","negative regulation of type I interferon production",0.00470491857723262,3.59687947882418,0.742497533329455,0.36781624,"negative regulation of viral genome replication"),
c("GO:0051092","positive regulation of NF-kappaB transcription factor activity",0.0281551580530444,1.29654609372244,0.826326999430714,0.41606446,"negative regulation of viral genome replication"),
c("GO:0043114","regulation of vascular permeability",0.00636547807507943,1.00223090083011,0.849834653639609,0.4171798,"negative regulation of viral genome replication"),
c("GO:0010606","positive regulation of cytoplasmic mRNA processing body assembly",0.00358961742196238,1.2151551460557,0.821487179973414,0.41784675,"negative regulation of viral genome replication"),
c("GO:1903020","positive regulation of glycoprotein metabolic process",0.00363918636219661,1.68329046143565,0.78151229911736,0.41815684,"negative regulation of viral genome replication"),
c("GO:0031397","negative regulation of protein ubiquitination",0.0163494887872579,2.05199622121155,0.77635626401716,0.43387641,"negative regulation of viral genome replication"),
c("GO:0071174","mitotic spindle checkpoint signaling",0.0339547240604497,1.68329046143565,0.709296807475074,0.45187906,"negative regulation of viral genome replication"),
c("GO:0050821","protein stabilization",0.045289488394011,1.85430834201967,0.850995623659175,0.47322645,"negative regulation of viral genome replication"),
c("GO:0045124","regulation of bone resorption",0.00570868961697584,1.04576302620993,0.79607012803133,0.52664727,"negative regulation of viral genome replication"),
c("GO:2000036","regulation of stem cell population maintenance",0.00484536390789628,1.00223090083011,0.813082445245129,0.52743337,"negative regulation of viral genome replication"),
c("GO:0046627","negative regulation of insulin receptor signaling pathway",0.00780297734187219,1.43801464777945,0.766629488176104,0.53148091,"negative regulation of viral genome replication"),
c("GO:0030948","negative regulation of vascular endothelial growth factor receptor signaling pathway",0.00308566652958101,1.15044524304861,0.776386839345912,0.57516383,"negative regulation of viral genome replication"),
c("GO:0034344","regulation of type III interferon production",0.000235452466112607,1.68329046143565,0.816730492603938,0.58549681,"negative regulation of viral genome replication"),
c("GO:0051225","spindle assembly",0.0480240415969328,1.49537464029424,0.934794153152121,0.602144,"negative regulation of viral genome replication"),
c("GO:0031953","negative regulation of protein autophosphorylation",0.00189601196395941,1.00223090083011,0.796307862622081,0.6865008,"negative regulation of viral genome replication"),
c("GO:0071902","positive regulation of protein serine/threonine kinase activity",0.046268474963637,1.28953876487758,0.737037777303465,0.68829445,"negative regulation of viral genome replication"),
c("GO:0051607","defense response to virus",0.146930600344306,7.73518217699046,0.704946084584678,0,"defense response to virus"),
c("GO:0038061","NIK/NF-kappaB signaling",0.00652244638582117,2.30356902912303,0.786654275878855,0.21556705,"defense response to virus"),
c("GO:0043330","response to exogenous dsRNA",0.00832345121433164,3.3829996588791,0.847284586983552,0.2188693,"defense response to virus"),
c("GO:0060071","Wnt signaling pathway, planar cell polarity pathway",0.00419683693983173,1.14625414027831,0.760395577207506,0.24590296,"defense response to virus"),
c("GO:0042493","response to drug",0.0598792798029535,1.39519769402877,0.853801702709633,0.38464488,"defense response to virus"),
c("GO:0007264","small GTPase mediated signal transduction",0.257304107265865,1.83101050804584,0.738838054659445,0.39790422,"defense response to virus"),
c("GO:0002479","antigen processing and presentation of exogenous peptide antigen via MHC class I, TAP-dependent",0.00050395089238137,2.3758745466339,0.864643445815264,0.498909,"defense response to virus"),
c("GO:0002223","stimulatory C-type lectin receptor signaling pathway",0.00106986296005553,3.09312646527793,0.607293091745229,0.55210267,"defense response to virus"),
c("GO:0006974","cellular response to DNA damage stimulus",2.55833148964414,1.65988657179202,0.812247899091625,0.57177417,"defense response to virus"),
c("GO:0030968","endoplasmic reticulum unfolded protein response",0.0395353605818204,1.09740471764723,0.708159153103,0.58268455,"defense response to virus"),
c("GO:0060333","interferon-gamma-mediated signaling pathway",0.00192905792411557,4.01727661233145,0.649676866037769,0.5988184,"defense response to virus"),
c("GO:0034340","response to type I interferon",0.00400682266893384,2.65931539683646,0.7322798107639,0.625111,"defense response to virus"),
c("GO:0030218","erythrocyte differentiation",0.0246192403163358,1.18648582293669,0.699416347800323,0.62971484,"defense response to virus"),
c("GO:0060337","type I interferon signaling pathway",0.00208602623485731,3.26841123481326,0.648456683062615,0.63226074,"defense response to virus"),
c("GO:0045830","positive regulation of isotype switching",0.00451077356131521,1.2151551460557,0.688085685347961,0.64060018,"defense response to virus"),
c("GO:0050900","leukocyte migration",0.0368586378091718,1.4108496916667,0.814566538991309,0.64732745,"defense response to virus"),
c("GO:0070555","response to interleukin-1",0.015746400014408,2.31651758891277,0.829535189647559,0.67356316,"defense response to virus"),
c("GO:0071222","cellular response to lipopolysaccharide",0.0230743416790355,1.51493768056846,0.767911797665567,0.67734222,"defense response to virus"),
c("GO:0009597","detection of virus",0.000739403358493977,1.29209566563865,0.832318200207048,0.69575525,"defense response to virus"),
c("GO:0075525","viral translational termination-reinitiation",0.00100790178476274,1.29209566563865,1,0,"viral translational termination-reinitiation"),
c("GO:0051603","proteolysis involved in cellular protein catabolic process",0.896016425164036,2.80932417045165,0.905851572769021,0.00935161,"proteolysis involved in cellular protein catabolic process"),
c("GO:0006687","glycosphingolipid metabolic process",0.0196127773526782,1.09740471764723,0.97163501653164,0.11441732,"proteolysis involved in cellular protein catabolic process"),
c("GO:0006364","rRNA processing",1.11831246838947,2.73276264526927,0.857760482836586,0.15025805,"proteolysis involved in cellular protein catabolic process"),
c("GO:0032020","ISG15-protein conjugation",0.00103268625487986,1.2151551460557,0.951681950302075,0.19637658,"proteolysis involved in cellular protein catabolic process"),
c("GO:0045006","DNA deamination",0.00135901511142189,1.38676111295478,0.941827959342932,0.21685018,"proteolysis involved in cellular protein catabolic process"),
c("GO:0032637","interleukin-8 production",0.000394486149364105,1.38676111295478,0.935926361122548,0.22426633,"proteolysis involved in cellular protein catabolic process"),
c("GO:0000209","protein polyubiquitination",0.0869976208560986,2.49533275792579,0.9389995473881,0.27040119,"proteolysis involved in cellular protein catabolic process"),
c("GO:0022617","extracellular matrix disassembly",0.0034450413462792,1.34682615048115,0.96467878082983,0.29380339,"proteolysis involved in cellular protein catabolic process"),
c("GO:0080009","mRNA methylation",0.0286301937302891,1.2151551460557,0.903914997339773,0.36428234,"proteolysis involved in cellular protein catabolic process"),
c("GO:0006413","translational initiation",0.515768953882215,1.25807007811323,0.91515285744673,0.38914292,"proteolysis involved in cellular protein catabolic process"),
c("GO:0000389","mRNA 3'-splice site recognition",0.00105747072499697,1.15044524304861,0.886421436381094,0.49129828,"proteolysis involved in cellular protein catabolic process"),
c("GO:0071051","polyadenylation-dependent snoRNA 3'-end processing",0.00466361112703743,1.29209566563865,0.910232791129884,0.4934929,"proteolysis involved in cellular protein catabolic process"),
c("GO:0071028","nuclear mRNA surveillance",0.0104714386244817,1.04576302620993,0.721010776815139,0.58505459,"proteolysis involved in cellular protein catabolic process"),
c("GO:0034427","nuclear-transcribed mRNA catabolic process, exonucleolytic, 3'-5'",0.0090380701027085,1.04576302620993,0.722996348243502,0.68876295,"proteolysis involved in cellular protein catabolic process"),
c("GO:0006120","mitochondrial electron transport, NADH to ubiquinone",0.0247679471370385,1.84062208250279,0.961673443818957,0.04914922,"mitochondrial electron transport, NADH to ubiquinone"));

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

