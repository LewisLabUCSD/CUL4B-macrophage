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

Also deposited under 10.5281/zenodo.15054297
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
│   │   └── phos_uniprot.tsv, prot_uniprot.tsv, *.xlsx
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

## 🛠️ Dependencies and Installation

### Software Environment

This analysis was performed using **R**, **Python**, and associated packages listed in `environment.yml`.\
Install via:

```bash
conda env create -f code/environment.yml
conda activate cul4b_env
```

### R Packages (key ones)

- `DESeq2`
- `fgsea`
- `ggplot2`
- `clusterProfiler`
- `REVIGO` dependencies

### Python Packages (notebooks)

- `pandas`
- `numpy`
- `matplotlib`
- `seaborn`

---

## 🚀 Usage Instructions

### Analysis Workflow

1. **Transcriptomic Analysis:**

   - Differential RNA expression results are stored in `data/DEG_RNA/`.
   - Conversion script:\
     `code/pkg/transcriptome__htseq_to_countMatrix.R`

2. **Proteomics & Phosphoproteomics Processing:**

   - Processed datasets in `data/uniprot/` and `.obj` files.
   - Summary notebooks in `code/pkg/0_dysregulated_proteins.ipynb` to `2_kinase.ipynb`.

3. **Pathway & Regulator Inference:**

   - IPA analysis inputs/exports in `data/IPA_export/`.
   - Regulatory analyses:\
     `code/pkg/4a_*.ipynb` to `6_UpSet_regulator_multiomic_targets.ipynb`.

4. **Network & Enrichment Visualization:**

   - Cytoscape input files: `results/cytoscape/`
   - REVIGO treemap generation:\
     `code/3_REVIGO/RevigoTreeMap_*.R`

5. **Downstream Results:**

   - Figures and results in `results/IPA_downstream_analysis/` and `regulator_pathways/`

---

## 📊 Results & Documentation

- **Processed differential expression results** (RNA, protein, phosphoprotein)
- **IPA upstream regulator predictions**
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
  [https://doi.org/10.5281/zenodo.15054297](https://doi.org/10.5281/zenodo.15054297)

- **Source code availability:**\
  Full code for data processing, statistical analysis, visualization, and figure generation is included.

- **Reproducibility:**\
  All scripts and notebooks are structured for re-execution given the provided data and environment file.

---

## 📝 License

This repository is licensed under the [MIT License](LICENSE).

---

## 📧 Contact

For questions or collaboration inquiries:\
**Lewis Lab, UC San Diego**\
[Lab Website](https://lewislab.ucsd.edu)

