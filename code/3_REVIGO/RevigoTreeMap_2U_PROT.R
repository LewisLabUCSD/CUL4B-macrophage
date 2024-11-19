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
revigo.data <- rbind(c("GO:0006364","rRNA processing",1.11831246838947,10.8894102897008,0.641604245608825,0,"rRNA processing"),
c("GO:0070816","phosphorylation of RNA polymerase II C-terminal domain",0.0129292319110958,2.65194340602906,0.773996108081419,0.10289625,"rRNA processing"),
c("GO:0046832","negative regulation of RNA export from nucleus",0.000388290031834826,1.52082955413645,0.893638926772601,0.11989338,"rRNA processing"),
c("GO:0030307","positive regulation of cell growth",0.0252718980294198,2.04294898935129,0.882011939154856,0.14893834,"rRNA processing"),
c("GO:0045454","cell redox homeostasis",0.18901463060317,1.52769769992662,0.897780051807115,0.17638737,"rRNA processing"),
c("GO:0009048","dosage compensation by inactivation of X chromosome",0.00273042245790234,1.226369333238,0.895438192872129,0.19181234,"rRNA processing"),
c("GO:0006356","regulation of transcription by RNA polymerase I",0.0126937794449832,1.05681473037343,0.892107460954314,0.23080229,"rRNA processing"),
c("GO:0050684","regulation of mRNA processing",0.0508701249153817,2.11308274005243,0.885204654511231,0.2478024,"rRNA processing"),
c("GO:0016925","protein sumoylation",0.0380895998249886,2.05004587412121,0.891022156851726,0.26040392,"rRNA processing"),
c("GO:0043484","regulation of RNA splicing",0.052964412640278,1.14674104155556,0.8833157256753,0.27090246,"rRNA processing"),
c("GO:0070125","mitochondrial translational elongation",0.00851759623024905,1.39286790361344,0.819212458539437,0.27396394,"rRNA processing"),
c("GO:0009116","nucleoside metabolic process",0.779120471856656,1.47960932240179,0.804155991458935,0.28777576,"rRNA processing"),
c("GO:0016310","phosphorylation",7.82329234587819,1.18060521619806,0.89413586275714,0.29349647,"rRNA processing"),
c("GO:0010501","RNA secondary structure unwinding",0.00363092487215757,7.77989191195995,0.840730548202329,0.31316835,"rRNA processing"),
c("GO:0042795","snRNA transcription by RNA polymerase II",0.00368049381239181,2.37557625184587,0.778067207888345,0.31345716,"rRNA processing"),
c("GO:0006357","regulation of transcription by RNA polymerase II",1.73988219445664,1.12992800957264,0.852822232727828,0.35343252,"rRNA processing"),
c("GO:0006362","transcription elongation from RNA polymerase I promoter",0.00176382812333479,1.98369612309961,0.779728996690365,0.36240972,"rRNA processing"),
c("GO:0000184","nuclear-transcribed mRNA catabolic process, nonsense-mediated decay",0.0632086602886862,8.45842075605342,0.631819774579318,0.38860849,"rRNA processing"),
c("GO:0006413","translational initiation",0.515768953882215,5.92081875395237,0.772114139088863,0.38914292,"rRNA processing"),
c("GO:0051292","nuclear pore complex assembly",0.00402334564901192,1.93771071229928,0.882003808094204,0.39132091,"rRNA processing"),
c("GO:0006015","5-phosphoribose 1-diphosphate biosynthetic process",0.0491558657322811,1.226369333238,0.876331900908238,0.39320874,"rRNA processing"),
c("GO:0006338","chromatin remodeling",0.160933825960477,1.37719015092283,0.890598388978615,0.39717803,"rRNA processing"),
c("GO:0010756","positive regulation of plasminogen activation",0.00244127030653598,1.13273178847251,0.861270717743558,0.40879316,"rRNA processing"),
c("GO:0045070","positive regulation of viral genome replication",0.00487427912303292,1.23064455346285,0.895195429221937,0.41472359,"rRNA processing"),
c("GO:0090611","ubiquitin-independent protein catabolic process via the multivesicular body sorting pathway",0.000731141868454938,1.13273178847251,0.889842919483865,0.42308658,"rRNA processing"),
c("GO:0006635","fatty acid beta-oxidation",0.104425234093451,2.35871097675235,0.88731895432547,0.4268847,"rRNA processing"),
c("GO:0002181","cytoplasmic translation",0.136438507994727,1.26114892637584,0.79315357480235,0.46729227,"rRNA processing"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.0391635935300636,1.81334282278333,0.881669648457513,0.48506835,"rRNA processing"),
c("GO:0010827","regulation of glucose transmembrane transport",0.0116776161701814,1.04953886069867,0.914242631443583,0.4916679,"rRNA processing"),
c("GO:0015936","coenzyme A metabolic process",0.188093474463817,1.226369333238,0.803738351643291,0.50425632,"rRNA processing"),
c("GO:0046952","ketone body catabolic process",0.0115660860546544,1.226369333238,0.89739053204272,0.50471806,"rRNA processing"),
c("GO:0006661","phosphatidylinositol biosynthetic process",0.3319508005136,1.23632080514845,0.859978433574709,0.52397191,"rRNA processing"),
c("GO:0030433","ubiquitin-dependent ERAD pathway",0.075613287582303,1.2007921459883,0.793774676913518,0.55793855,"rRNA processing"),
c("GO:0045893","positive regulation of transcription, DNA-templated",0.701412896549456,1.90645149730177,0.820002629178893,0.58352661,"rRNA processing"),
c("GO:0000122","negative regulation of transcription by RNA polymerase II",0.184103174774961,1.08199434873248,0.823533358061713,0.5932512,"rRNA processing"),
c("GO:0006396","RNA processing",3.83107599133337,5.66554624884907,0.721556977183624,0.59427593,"rRNA processing"),
c("GO:0031054","pre-miRNA processing",0.00651005415076261,3.05354773498693,0.666444772631744,0.59617134,"rRNA processing"),
c("GO:0009156","ribonucleoside monophosphate biosynthetic process",1.10783689901997,1.13273178847251,0.734747412501535,0.59981157,"rRNA processing"),
c("GO:0009083","branched-chain amino acid catabolic process",0.0379450237493054,1.47960932240179,0.887972669373297,0.60443598,"rRNA processing"),
c("GO:0007077","mitotic nuclear membrane disassembly",9.50071354489467E-05,1.53730739729903,0.907035402652206,0.62600024,"rRNA processing"),
c("GO:0006351","transcription, DNA-templated",2.0006354738138,1.18218430115909,0.683971335617697,0.64245966,"rRNA processing"),
c("GO:0043065","positive regulation of apoptotic process",0.0874354798281676,1.39629110911738,0.863300256616454,0.64387378,"rRNA processing"),
c("GO:0006360","transcription by RNA polymerase I",0.0380276386496958,1.05681473037343,0.760712760387024,0.64826228,"rRNA processing"),
c("GO:0008380","RNA splicing",0.617955324175086,6.60906489289662,0.736315428715684,0.65492696,"rRNA processing"),
c("GO:0006412","translation",5.34694375263645,4.46980030179692,0.723586431445891,0.67137328,"rRNA processing"),
c("GO:0000398","mRNA splicing, via spliceosome",0.436433865037325,3.22112552799726,0.71215034176631,0.69012573,"rRNA processing"),
c("GO:0070126","mitochondrial translational termination",0.00107812445009457,1.37719015092283,0.777468391169118,0.69023928,"rRNA processing"),
c("GO:0006370","7-methylguanosine mRNA capping",0.0293158974035293,1.04953886069867,0.763856625042038,0.69062701,"rRNA processing"),
c("GO:0043044","ATP-dependent chromatin remodeling",0.0583095966955362,1.32661724076766,0.896841149384108,0.69424803,"rRNA processing"),
c("GO:0008152","metabolic process",62.7747296551307,2.3778058861088,1,0,"metabolic process"),
c("GO:0014823","response to activity",0.00649766191570405,2.39497672757095,0.968244706244362,0,"response to activity"),
c("GO:0048015","phosphatidylinositol-mediated signaling",0.0495689402342331,1.64223027514739,0.880425753417306,0.2019415,"response to activity"),
c("GO:0043555","regulation of translation in response to stress",0.00912481574811841,1.52082955413645,0.838462807619352,0.22925981,"response to activity"),
c("GO:0030518","intracellular steroid hormone receptor signaling pathway",0.0101533712579787,1.62051624756209,0.863994566953224,0.28850826,"response to activity"),
c("GO:0002931","response to ischemia",0.00464295740193983,1.04953886069867,0.959350813554803,0.3021697,"response to activity"),
c("GO:0043620","regulation of DNA-templated transcription in response to stress",0.0200630285598058,1.05681473037343,0.851580680397418,0.37616649,"response to activity"),
c("GO:1990090","cellular response to nerve growth factor stimulus",0.00297413641405398,1.0962784186003,0.93571662265863,0.54585792,"response to activity"),
c("GO:0016032","viral process",0.168311336565338,2.21010274748094,1,0,"viral process"),
c("GO:0019083","viral transcription",0.00397377670877768,5.96657624451305,0.962001037511559,0,"viral transcription"),
c("GO:0075733","intracellular transport of virus",0.00549802162098035,2.12950043942941,0.932700920940829,0.63949866,"viral transcription"),
c("GO:0001649","osteoblast differentiation",0.0160809903609891,1.67394857380504,0.958802689604345,0.00785798,"osteoblast differentiation"),
c("GO:0031100","animal organ regeneration",0.00426292886014404,1.46368984561238,0.96562657636195,0.40745674,"osteoblast differentiation"),
c("GO:0019827","stem cell population maintenance",0.0250777530135024,1.39559529536175,0.967527836613116,0.44986326,"osteoblast differentiation"),
c("GO:0003157","endocardium development",0.00299479013915158,1.34802732190006,0.966082626421811,0.48036983,"osteoblast differentiation"),
c("GO:0060612","adipose tissue development",0.00615894082410346,1.26114892637584,0.965145496019188,0.49790003,"osteoblast differentiation"),
c("GO:0042113","B cell activation",0.0258130256269769,1.14674104155556,0.981011448361464,0.00814952,"B cell activation"),
c("GO:0060337","type I interferon signaling pathway",0.00208602623485731,1.13408540306737,0.85645882425977,0.49056201,"B cell activation"),
c("GO:0006614","SRP-dependent cotranslational protein targeting to membrane",0.1423372118826,4.03857890593355,0.905032106700806,0.00940891,"SRP-dependent cotranslational protein targeting to membrane"),
c("GO:0007080","mitotic metaphase plate congression",0.0187329286635206,1.73544789542635,0.836727707402411,0.50934814,"SRP-dependent cotranslational protein targeting to membrane"),
c("GO:0006406","mRNA export from nucleus",0.0827883916812083,3.08249449044745,0.754462207939087,0.57642692,"SRP-dependent cotranslational protein targeting to membrane"),
c("GO:0006888","endoplasmic reticulum to Golgi vesicle-mediated transport",0.166022903824525,1.0126697764602,0.910891615487545,0.60738666,"SRP-dependent cotranslational protein targeting to membrane"),
c("GO:0098609","cell-cell adhesion",0.22244888079116,1.25703566447519,0.988693165209348,0.00980518,"cell-cell adhesion"),
c("GO:0007049","cell cycle",1.75270402699723,1.31785568711834,0.986597722229976,0.01217594,"cell cycle"),
c("GO:0022904","respiratory electron transport chain",0.481739876411414,1.43814332192151,0.93060192079594,0.06509815,"respiratory electron transport chain"),
c("GO:0006120","mitochondrial electron transport, NADH to ubiquinone",0.0247679471370385,1.41772323185823,0.941643847933764,0.64161876,"respiratory electron transport chain"));

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

