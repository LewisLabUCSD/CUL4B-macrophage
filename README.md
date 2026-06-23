## CUL4B-macrophage

This repository contains multi-omics analysis code and data for the following manuscript. The analysis integrates differential expression, pathway enrichment, network inference, and regulatory protein prediction.

**Integrative Multi-omics Analysis Reveals Cul4B Regulation of Macrophage Pyroptosis and Innate Defense to Staphylococcus aureus**.

*Fatemeh Askarian, Daniel Sun, Jasmine Tat, James Sorrentino, Consuelo Sauceda, Armin Kousha, Siri Yendluri, Yu Yan, Ka Yau, Helen Masson, Jacob Wozniac, Kristin Pettersen, Natalie Chavarria, Alexandria Hoffman, Stanley Davis, Chih-Ming Tsai, Angela Meier, George Sakulas, Tom Eirik Mollnes, Gustav Vaaje-Kolstad, Ingrid Cornax, Mona Johannessen, Ben Croker, Pengbo Zho, David Gonzalez, Nathan E. Lewis, Victor Nizet*

---


The repository provides:

- Jupyter notebooks and R scripts for data analysis and visualization.
- Processed input and output data files for reproducibility.
- Enrichment and network inference results.
- REVIGO visualization scripts for semantic summarization of enrichment analyses.
- Code and data are also deposited under 10.5281/zenodo.15401096
---

## 📁 Repository Structure

```
CUL4B-macrophage/
├── code/
│   ├── 3_REVIGO/
│   │   └── RevigoTreeMap_*PROT.R       # REVIGO treemap generation scripts
│   ├── pkg/
│   │   ├── *.ipynb                     # Jupyter notebooks for analysis
│   │   └── transcriptome__htseq_to_countMatrix.R
│   └── environment.yml
│
├── data/
│   ├── DEG_RNA/
│   │   └── DResults_*.xlsx             # Differential expression results (RNA)
│   ├── IPA_export/
│   │   ├── ipa_anno.txt
│   │   └── upstream/
│   ├── uniprot/
│   │   └── prot_uniprot.tsv, *.xlsx
│   └── macro_*                         # Processed dataframes (.obj, .csv)
│
├── results/
│   ├── IPA_downstream_analysis/
│   ├── cytoscape/                      # Cytoscape network files
│   └── regulator_pathways/
│
├── LICENSE
└── README.md
```

---

## 🛠️ Dependencies and Software

### Software Environment

This analysis was performed using **R**, **Python**, and the following software/tools

### R Packages (key ones)

- `DESeq2`
- `fgsea`
- `ggplot2`
- `clusterProfiler`
- `REVIGO`
- `ComplexUpset`

### Python Packages (notebooks)

- `pandas`
- `numpy`
- `matplotlib`
- `seaborn`
- `scipy`
- `sklearn`
- `statsmodels`
- `venn`
- `UpSet`

### Software and Tools
- QIAGEN Inc. Ingenuity Pathway Analysis suite (IPA)
- Metascape
- REVIGO
- Cytoscape
- CORAL
- 

---

## 🚀 Usage Instructions

### Analysis Workflow

1. **Transcriptomic Analysis:**
   - Conversion script from htseq to counts: `code/transcriptome__htseq_to_countMatrix.R`
   - Raw counts table is deposited under GSE288437
   - DESeq2 differential RNA expression results DESeq2 are in `data/DEG_RNA/`.

2. **Proteomics Processing and Cluster Enrichment:**

   - Processed datasets in `data/uniprot/` and `.obj` files.
   - `code/0_dysregulated_proteins.ipynb` t-test, ANOVA to identify differentially abundance proteins and plot volcano/PCA plots. Outputs are in `results/ttests/`
   - `code/1_abundance_clustering.ipynb` k-means clustering to define timepoint clusters
   - 
3. **IPA Enriched Regulator Processing and Analysis:**
   - `code/2_kinase.ipynb` downstream analysis and visualization of kinase enrichment results from CORAL (et al.)
   - `code/3_REVIGO/*.R` R scripts to generate TreeMap visualizations from REVIGO enrichment
   - `code/4a_IPA_identify_regulators.ipynb` identify the signifcantly enriched regulators from IPA across all timepoint and compile the unique/shared target genes per timepoint. Outputs are in `results/IPA_downstream_analysis/upstream_causal/`
   - `code/4b_IPA_regulators_shared_proteins.ipynb` compile target differentially expressed/abundance genes/proteins for 7 causal network regulators (AREG, ATM, CUL4B, MYC, Pkg, ROCK, Rac) for each timepoint from proteomics data and for each significant z-score derived from IPA. Output file: `results/IPA_downstream_analysis/PROT_sharedreg.xlsx`
   - `code/4c_IPA_regulator_multiomics_data.ipynb` compile all multi-omics data for differentially abundant protein targets for IPA enriched and shared regulators. Outputs are in `results/IPA_downstream_analysis/regulator_pathways/{}_REGULATOR_PATHWAYS.xlsx`
   - `code/5a_IPA_regulator_network_cytoscape_input.ipynb` compile enriched gene/protein targets for each regulator as inputs for for Cytoscape network generation (`results/IPA_downstream_analysis/cytoscape/`)
   - `code/5b_CUL4B_network_cytoscape_input.ipynb` compiled enriched gene/protein targets for CUL4B as input for Cytoscape network generation (`results/IPA_downstream_analysis/cytoscape/`)
   - `code/6_UpsetR_proteomics_transcriptomics.ipynb` compile the differentially expressed genes, proteins targeted by IPA enriched regulators to generate UpSet plot

---

## 📊 Results & Documentation

- **Processed differential expression results** (RNA, proteins)
- **IPA enriched upstream regulator predictions**
- **Multi-omics regulatory network inference**
- **REVIGO semantic similarity treemaps**
- **Cytoscape-formatted networks**

Each Jupyter notebook and R script contains embedded usage notes and data source documentation.

---

## 📚 Reporting Information (Nature’s Code & Software Guidelines)

- **Software versioning:**\
  Complete dependency list in `code/environment.yml`.

- **Data availability:**\
  Processed datasets are provided in `data/`. Raw data referenced in the corresponding manuscript and Zenodo entry:\
  [https://doi.org/10.5281/zenodo.15054296]

- **Source code availability:**\
  Full code for data processing, statistical analysis, visualization, and figure generation is included.

- **Reproducibility:**\
  All scripts and notebooks are structured for re-execution given the provided data and software dependencies.

---

## 📝 License

This repository is licensed under the [MIT License](LICENSE).

