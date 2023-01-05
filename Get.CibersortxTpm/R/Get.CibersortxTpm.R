suppressMessages(library(tidyverse))

#' Title
#'
#' @param seuart_object seuart object
#' @param celltype_varname The name of the variable in the seuart object that represents the cell type
#' @param select_allcells Whether to select all cell types,default is FALSE
#' @param gsub_cellname Whether to replace useless strings in cell names,default is FALSE
#' @param specified_cells The specified cell type names
#' @param cl The number of cores used for parallel computing
#' @param write_filename Output file location
#' @param gsub_string Which string you want to convert a useless string to
#' @param sep
#' @param row.names
#' @param col.names
#'
#' @return
#' @export
#'
#' @examples
Get.CibersortxTpm <-
  function(seuart_object=seuart_object, celltype_varname=celltype_varname,
           select_allcells=F, gsub_cellname=F,
           specified_cells=specified_cells,cl=1,
           write_filename=NULL, gsub_string=gsub_string,
           sep = '\t',row.names =F ,col.names =T){
    #Get meta data
    meta <- seuart_object@meta.data
    counts=as.data.frame(GetAssayData(seuart_object, assay = "RNA", slot = "counts"))

    #Start calculating the TPM
    if (select_allcells==T) {
      counts <- counts[,rownames(meta)]
      tpm.like <- pbapply(counts,2,cl = cl,function(x){x/sum(x)*10000})
      print('select all cells!')
    }else{
      meta2 <- meta %>% select(celltype_varname)
      meta <- meta[meta2[,1]%in%specified_cells,]
      counts <- counts[,rownames(meta)]
      tpm.like <- pbapply(counts,2,cl = cl,function(x){x/sum(x)*10000})
      print('select specified cells!')
    }

    #Add cell annotation information
    cell.anno=meta[,celltype_varname] %>% as.character()
    tpm.like<- rbind('gene'=cell.anno,tpm.like) %>% as.data.frame()

    #It is recommended to remove unnecessary characters of cell names to avoid errors
    if (gsub_cellname==T) {
      tpm.like[1,] <- gsub(pattern = gsub_string[1],replacement = gsub_string[2] ,
                           tpm.like[1,])
    }

    #Output the TPM-like matrix file
    if (!(is_null(write_filename))){
      fwrite(tpm.like,file =write_filename,sep = seq,row.names =row.names ,col.names =col.names )
    }

    return(tpm.like)
  }
