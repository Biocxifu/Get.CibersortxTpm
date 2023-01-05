#### require
[![ForgiveDB](https://img.shields.io/badge/CRAN-pbapply-brightgreen.svg)](https://cran.r-project.org/web/packages/pbapply/) [![ForgiveDB](https://img.shields.io/badge/CRAN-Seurat-brightgreen.svg)](https://cran.r-project.org/web/packages/Seurat/index.html)  [![ForgiveDB](https://img.shields.io/badge/CRAN-SeuratObject-brightgreen.svg)](https://cran.r-project.org/web/packages/SeuratObject/index.html)   [![ForgiveDB](https://img.shields.io/badge/CRAN-tidyverse-brightgreen.svg)](https://cran.r-project.org/web/packages/tidyverse/) [![ForgiveDB](https://img.shields.io/badge/CRAN-data.table-brightgreen.svg)](https://cran.r-project.org/web/packages/data.table/)
# Get.CibersortxTpm

**Get the single-cell sequencing TPM matrix required by CIBERSORTX**

The R package can extract the counts matrix in the seuart object to calculate the TPM value and match the corresponding cell name. It supports multi-core computation to speed up computation runs, and the resulting output file can be directly input into CIBERSORTX to create a Signature Matrix

## Install
```
devtools::install_github('BioCheng/Get.CibersortxTpm')
```  
## Usage

### Load example data
```
library(SeuratData)
library(Get.CibersortxTpm)
data("pbmc3k")
pbmc3k <- pbmc3k[,1:100]
```

### Start running
##### *You can select all cells*
```
Cibersortx_Tpm <- Get_Cibersortx_Tpm(seuart_object = pbmc3k, select_allcells = FALSE,
                                     celltype_varname = 'seurat_annotations',
                                     specified_cells = c('Naive CD4 T','Memory CD4 T','B'),
                                     gsub_cellname = T,gsub_string = c(' ','_'),
                                     write_filename = 'test.txt')

```

##### *Or you can select specific cells*
```
Cibersortx_Tpm <- Get_Cibersortx_Tpm(seuart_object = seuart_object,select_allcells =TRUE,
                                     celltype_varname = 'seurat_annotations',
                                     gsub_cellname = T,gsub_string = c(' ','_'),
                                     write_filename = 'test.txt')
```



CIBERSORTX:
[Build a Signature Matrix File from Single-Cell RNA Sequencing Data](https://cibersortx.stanford.edu/tutorial.php)    
