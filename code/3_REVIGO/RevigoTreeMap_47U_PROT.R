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
revigo.data <- rbind(c("GO:0008152","metabolic process",62.7747296551307,1.2016412475611,1,0,"metabolic process"),
c("GO:0016032","viral process",0.168311336565338,2.7975720963053,1,0,"viral process"),
c("GO:0019083","viral transcription",0.00397377670877768,4.74714696902011,0.987970384777278,0,"viral transcription"),
c("GO:0075733","intracellular transport of virus",0.00549802162098035,2.80650945508351,0.95149647990407,0.63949866,"viral transcription"),
c("GO:0070125","mitochondrial translational elongation",0.00851759623024905,6.78781239559604,0.842599679106886,0,"mitochondrial translational elongation"),
c("GO:0006694","steroid biosynthetic process",0.132985205158408,1.79797005283925,0.856176045060057,0.13901849,"mitochondrial translational elongation"),
c("GO:0031145","anaphase-promoting complex-dependent catabolic process",0.0324965710685593,1.98782289794688,0.887972129722227,0.18275804,"mitochondrial translational elongation"),
c("GO:0016925","protein sumoylation",0.0380895998249886,1.3348938428702,0.904958171620544,0.19996899,"mitochondrial translational elongation"),
c("GO:0008652","cellular amino acid biosynthetic process",3.08287414594781,3.07211658966929,0.843281715065404,0.2470682,"mitochondrial translational elongation"),
c("GO:0006364","rRNA processing",1.11831246838947,5.49894073778225,0.717551983069035,0.27396394,"mitochondrial translational elongation"),
c("GO:0035338","long-chain fatty-acyl-CoA biosynthetic process",0.00524191542977015,1.48607461392289,0.831400741574901,0.27460671,"mitochondrial translational elongation"),
c("GO:0036109","alpha-linolenic acid metabolic process",4.95689402342331E-05,1.71798525255184,0.937380706644378,0.28415494,"mitochondrial translational elongation"),
c("GO:0006406","mRNA export from nucleus",0.0827883916812083,3.57348873863542,0.781087418315258,0.32772035,"mitochondrial translational elongation"),
c("GO:0006369","termination of RNA polymerase II transcription",0.016056205890872,1.65739730964357,0.818821893110754,0.34835749,"mitochondrial translational elongation"),
c("GO:0043044","ATP-dependent chromatin remodeling",0.0583095966955362,3.28232949699774,0.879292648867462,0.36340847,"mitochondrial translational elongation"),
c("GO:0006413","translational initiation",0.515768953882215,3.31069114087638,0.803149604112421,0.38914292,"mitochondrial translational elongation"),
c("GO:1903608","protein localization to cytoplasmic stress granule",0.00127226946601198,2.25923449175813,0.910922763752832,0.39839865,"mitochondrial translational elongation"),
c("GO:0016236","macroautophagy",0.0783561022752639,1.41864529389972,0.942338103102803,0.40010464,"mitochondrial translational elongation"),
c("GO:0006260","DNA replication",1.52888373885959,1.34066096169767,0.850216761565293,0.41353714,"mitochondrial translational elongation"),
c("GO:0006281","DNA repair",2.38776476629814,2.69397669442718,0.704125323758623,0.41375493,"mitochondrial translational elongation"),
c("GO:0071475","cellular hyperosmotic salinity response",0.000417205246971462,1.48053759852973,0.878354023458659,0.41569333,"mitochondrial translational elongation"),
c("GO:0000722","telomere maintenance via recombination",0.00706770472839773,1.00363886744224,0.785664954606813,0.44454783,"mitochondrial translational elongation"),
c("GO:0046033","AMP metabolic process",0.179592401213646,1.09340708416141,0.841082940014641,0.44808207,"mitochondrial translational elongation"),
c("GO:0098869","cellular oxidant detoxification",0.889828569124796,1.5313911271455,0.867797597291479,0.45846731,"mitochondrial translational elongation"),
c("GO:0032981","mitochondrial respiratory chain complex I assembly",0.0391635935300636,2.4007578278194,0.870851538061604,0.46349347,"mitochondrial translational elongation"),
c("GO:0042769","DNA damage response, detection of DNA damage",0.00124335425087535,1.6608362139285,0.882905168976899,0.47532255,"mitochondrial translational elongation"),
c("GO:0070987","error-free translesion synthesis",0.00320958888016659,2.43809782656094,0.759846492675033,0.50733332,"mitochondrial translational elongation"),
c("GO:0007596","blood coagulation",0.0482140558678307,1.91404023516406,0.789466638345141,0.51227897,"mitochondrial translational elongation"),
c("GO:0033683","nucleotide-excision repair, DNA incision",0.0057004281269368,2.44661514325933,0.773402866453496,0.52890785,"mitochondrial translational elongation"),
c("GO:0042493","response to drug",0.0598792798029535,1.1607965648269,0.903911819527366,0.53264105,"mitochondrial translational elongation"),
c("GO:0030041","actin filament polymerization",0.0232643559499334,2.04671455006329,0.885623481843833,0.53757545,"mitochondrial translational elongation"),
c("GO:0070911","global genome nucleotide-excision repair",0.00064026547802551,1.00363886744224,0.795909206262801,0.54535086,"mitochondrial translational elongation"),
c("GO:0006294","nucleotide-excision repair, preincision complex assembly",0.000669180693162147,1.07670064660502,0.736043693305374,0.54646161,"mitochondrial translational elongation"),
c("GO:0000717","nucleotide-excision repair, DNA duplex unwinding",0.0010202940198213,1.28895323194579,0.726965179232543,0.55730058,"mitochondrial translational elongation"),
c("GO:0006337","nucleosome disassembly",0.00656375383601636,1.49549106480152,0.872598256862777,0.56419003,"mitochondrial translational elongation"),
c("GO:0006104","succinyl-CoA metabolic process",0.00359787891200142,1.09340708416141,0.853733255062449,0.56552927,"mitochondrial translational elongation"),
c("GO:0006296","nucleotide-excision repair, DNA incision, 5'-to lesion",0.00205298027470115,2.48927193089803,0.784496995083591,0.57624764,"mitochondrial translational elongation"),
c("GO:0006614","SRP-dependent cotranslational protein targeting to membrane",0.1423372118826,3.00480370840282,0.879006581246314,0.57642692,"mitochondrial translational elongation"),
c("GO:0006297","nucleotide-excision repair, DNA gap filling",0.0027015072427657,2.14485260617451,0.781621736102803,0.58404351,"mitochondrial translational elongation"),
c("GO:0055129","L-proline biosynthetic process",0.123649721414294,2.57185869678837,0.819121718028325,0.58455993,"mitochondrial translational elongation"),
c("GO:0032508","DNA duplex unwinding",0.67379473534895,2.21583515655303,0.86284178370862,0.60731411,"mitochondrial translational elongation"),
c("GO:0000398","mRNA splicing, via spliceosome",0.436433865037325,4.64975198166584,0.780700927483845,0.63198393,"mitochondrial translational elongation"),
c("GO:0007062","sister chromatid cohesion",0.117899724347123,1.53686861354013,0.876262350412994,0.64372619,"mitochondrial translational elongation"),
c("GO:0008380","RNA splicing",0.617955324175086,4.64397414280688,0.795245925289891,0.65492696,"mitochondrial translational elongation"),
c("GO:0006412","translation",5.34694375263645,4.03105031901866,0.761774674131701,0.67137328,"mitochondrial translational elongation"),
c("GO:0006283","transcription-coupled nucleotide-excision repair",0.0404317322510561,1.45489295983697,0.748650773614042,0.67390677,"mitochondrial translational elongation"),
c("GO:0000184","nuclear-transcribed mRNA catabolic process, nonsense-mediated decay",0.0632086602886862,2.41893866176492,0.713764968083535,0.69012573,"mitochondrial translational elongation"),
c("GO:0070126","mitochondrial translational termination",0.00107812445009457,6.73518217699046,0.791473682056462,0.69023928,"mitochondrial translational elongation"),
c("GO:0006338","chromatin remodeling",0.160933825960477,2.50279707043505,0.87196675346424,0.69424803,"mitochondrial translational elongation"),
c("GO:1901796","regulation of signal transduction by p53 class mediator",0.0125781185844366,2.9496018401747,0.897528566131916,0,"regulation of signal transduction by p53 class mediator"),
c("GO:0038061","NIK/NF-kappaB signaling",0.00652244638582117,2.31395737969309,0.857483980371102,0.13788334,"regulation of signal transduction by p53 class mediator"),
c("GO:0010827","regulation of glucose transmembrane transport",0.0116776161701814,1.76185507900774,0.907791799962626,0.14233586,"regulation of signal transduction by p53 class mediator"),
c("GO:0032968","positive regulation of transcription elongation from RNA polymerase II promoter",0.031149948192196,1.65578609171912,0.889958671624399,0.1505241,"regulation of signal transduction by p53 class mediator"),
c("GO:0043087","regulation of GTPase activity",0.157951428056384,1.63536980893544,0.920893962702123,0.15466189,"regulation of signal transduction by p53 class mediator"),
c("GO:0001975","response to amphetamine",0.00280890661327321,1.0270432734251,0.91812895105185,0.17316509,"regulation of signal transduction by p53 class mediator"),
c("GO:2000757","negative regulation of peptidyl-lysine acetylation",0.00554759056121458,1.09340708416141,0.899848764811268,0.2043541,"regulation of signal transduction by p53 class mediator"),
c("GO:0060071","Wnt signaling pathway, planar cell polarity pathway",0.00419683693983173,1.72410289837952,0.853293314693164,0.24590296,"regulation of signal transduction by p53 class mediator"),
c("GO:0043488","regulation of mRNA stability",0.10022013566358,1.53686861354013,0.882915284726019,0.27356607,"regulation of signal transduction by p53 class mediator"),
c("GO:0007249","I-kappaB kinase/NF-kappaB signaling",0.0210957148146857,1.75007385014864,0.848442093661938,0.34292359,"regulation of signal transduction by p53 class mediator"),
c("GO:2000676","positive regulation of type B pancreatic cell apoptotic process",0.000206537250975971,1.18672395089418,0.924405129688878,0.36512778,"regulation of signal transduction by p53 class mediator"),
c("GO:0061000","negative regulation of dendritic spine development",0.00109051668515313,1.01780896507655,0.912037801519487,0.40139707,"regulation of signal transduction by p53 class mediator"),
c("GO:0002223","stimulatory C-type lectin receptor signaling pathway",0.00106986296005553,1.50573820165039,0.823143909080035,0.42996604,"regulation of signal transduction by p53 class mediator"),
c("GO:0051881","regulation of mitochondrial membrane potential",0.0124748499589487,1.10308968028109,0.924382127093046,0.43483901,"regulation of signal transduction by p53 class mediator"),
c("GO:0042059","negative regulation of epidermal growth factor receptor signaling pathway",0.0050188551987161,1.6608362139285,0.868497642142361,0.49874028,"regulation of signal transduction by p53 class mediator"),
c("GO:0032732","positive regulation of interleukin-1 production",0.0114256407239907,1.18672395089418,0.900394701875037,0.5011425,"regulation of signal transduction by p53 class mediator"),
c("GO:0046425","regulation of receptor signaling pathway via JAK-STAT",0.0122641819629532,1.09340708416141,0.899156494052868,0.52351427,"regulation of signal transduction by p53 class mediator"),
c("GO:0010793","regulation of mRNA export from nucleus",0.00217277188026722,1.01780896507655,0.916099240032036,0.53444518,"regulation of signal transduction by p53 class mediator"),
c("GO:0000122","negative regulation of transcription by RNA polymerase II",0.184103174774961,1.02303755545975,0.871077995395345,0.55399261,"regulation of signal transduction by p53 class mediator"),
c("GO:1903959","regulation of anion transmembrane transport",0.00415966023465606,1.49549106480152,0.912171014382338,0.62802063,"regulation of signal transduction by p53 class mediator"),
c("GO:2000145","regulation of cell motility",0.174771821775867,1.10308968028109,0.897226465224386,0.63674072,"regulation of signal transduction by p53 class mediator"),
c("GO:0043086","negative regulation of catalytic activity",0.532808277087732,1.43661004828591,0.915242465454268,0.65712857,"regulation of signal transduction by p53 class mediator"),
c("GO:0046578","regulation of Ras protein signal transduction",0.103384286348532,1.01780896507655,0.885956914010229,0.67785981,"regulation of signal transduction by p53 class mediator"),
c("GO:0007077","mitotic nuclear membrane disassembly",9.50071354489467E-05,1.43445306195412,0.90842047568691,0.00447338,"mitotic nuclear membrane disassembly"),
c("GO:0017145","stem cell division",0.00470904932225214,1.18672395089418,0.99220698998616,0.00537649,"stem cell division"),
c("GO:0098609","cell-cell adhesion",0.22244888079116,3.18708664335714,0.989989562293263,0.00671557,"cell-cell adhesion"),
c("GO:0001649","osteoblast differentiation",0.0160809903609891,2.10130109824407,0.961737599991688,0.00700308,"osteoblast differentiation"),
c("GO:0021766","hippocampus development",0.010529269054755,1.8508442379732,0.966712094715696,0.42804589,"osteoblast differentiation"),
c("GO:0061198","fungiform papilla formation",0.00035937481669819,1.30805952242789,0.969363694211438,0.45344396,"osteoblast differentiation"),
c("GO:0060789","hair follicle placode formation",0.00049982014736185,1.01780896507655,0.969015871415685,0.46044521,"osteoblast differentiation"),
c("GO:0006890","retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum",0.0737007526382655,1.31707931946949,0.949194878486255,0.00780341,"retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum"),
c("GO:0001667","ameboidal-type cell migration",0.0465824115851205,1.18672395089418,0.951954078379338,0.17906362,"retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum"),
c("GO:0006099","tricarboxylic acid cycle",0.547166746775582,2.88813056760012,0.931456414777673,0.04691012,"tricarboxylic acid cycle"),
c("GO:0006069","ethanol oxidation",0.0180967939305146,1.78578158414878,0.908740708801183,0.47669244,"tricarboxylic acid cycle"),
c("GO:0006120","mitochondrial electron transport, NADH to ubiquinone",0.0247679471370385,1.31714284374499,0.945493144334293,0.67401444,"tricarboxylic acid cycle"),
c("GO:0005975","carbohydrate metabolic process",5.96269325897111,1.14492084943263,0.944998932885008,0.08519136,"carbohydrate metabolic process"));

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

