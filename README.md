# Get.CibersortxTpm
**Get the single-cell sequencing TPM matrix required by CIBERSORTX**

##Install
`devtools::install_github('dviraran/SingleR')` 

##Usage
`data(pbmc3K)
Cibersortx_Tpm <- Get_Cibersortx_Tpm(seuart_object = seuart_object,celltype_varname = 'seurat_annotations',
                   select_allcells = F,specified_cells = c('Naive CD4 T','Memory CD4 T','B'),
                   gsub_cellname = T,gsub_string = c(' ','_'),write_filename = 'test.txt')
`
