#' Combines samples from two different tss experiments into a single GRanges object
#' @param experimentName - an S4 object of class tssObject that contains information about the experiment.
#' @return tssCountData datasets will be merged (according to the sampleIDs) and assigned to your tssObject object
#' @importFrom GenomicRanges as.data.frame
#' @importFrom gtools mixedorder
#' @export

setGeneric(
    name="mergeSampleData",
    def=function(experimentName) {
        standardGeneric("mergeSampleData")
    }
    )

setMethod("mergeSampleData",
          signature(experimentName="tssObject"),
          function(experimentName) {
              object.name <- deparse(substitute(experimentName))

              if (length(experimentName@tssCountData)==0) {
                  stop("\nThe slot @tssCountData is empty. Please run processTSS before proceeding with this command.\n")
              }

              if (length(experimentName@sampleNames) < 1) {
                  stop("\nThe slot @sampleNames on your tssObject object is empty. Please add sampleNames to the object.\n")
              }

              if (length(experimentName@replicateIDs) < 1) {
                  stop("\nThe slot @replicateIDs on your tssObject object is empty. Please add replicateIDs to the object.\n")
              }

              rep.ids <- experimentName@replicateIDs
              uni.ids <- unique(rep.ids)
              exp.data <- experimentName@tssCountData
              exp.list <- vector(mode="list")

              for (i in seq_along(uni.ids)) {
                  data.frame() -> my.df
                  which(rep.ids==i) -> my.ind
                  exp.data[my.ind] -> replicate.set
                  for (j in 1:length(replicate.set)) {
                      rbind(my.df, replicate.set[[j]]) -> my.df
                  }
                  my.df <- my.df[with(my.df, order(chr, TSS)),]
                  my.df <- my.df[with(my.df, mixedorder(chr)),]
                  my.df -> exp.list[[i]]
              }

#VB: The following few lines merge the merged tssCountData into the last experimentName@tssCountDataMerged slot,
#    representing the entire collection of TSS tag counts in the experiment
 
              data.frame() -> my.df
              for (i in seq_along(uni.ids)) {
                  rbind(my.df, exp.list[[i]]) -> my.df
	      }
              my.df <- my.df[with(my.df, order(chr, TSS)),]
              my.df <- my.df[with(my.df, mixedorder(chr)),]
              my.df -> exp.list[[i+1]]

              experimentName@tssCountDataMerged <- exp.list
              cat("\n... the TSS expression data has been successfully merged and added to\ntssObject object \"", object.name, "\"\n")
              cat("--------------------------------------------------------------------------------\n")
              assign(object.name, experimentName, envir = parent.frame())
              message(" Done.\n")
          }
          )