% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prcTSS.R
\name{prcTSS}
\alias{prcTSS}
\title{\emph{prcTSS()}}
\usage{
prcTSS(experimentName, tssSet, writeTable)
}
\arguments{
\item{experimentName}{- a S4 object of class tssObject containing
information in slot tssTagData}

\item{tssSet}{- number of the dataset to be analyzed}

\item{writeTable}{- if set to TRUE, writes a data frame containing
the TSSs positions and their abundance to your workspace}
}
\value{
\emph{prcTSS} fills the slot experimentName@tssCountData[[tssSet]]
in the tssObject \emph{experimentName} with a matrix of unique TSS positions
(rows) and observed tag counts in each position for data set tssSet;
precisely, each entry of the matrix consists of "seq" (chr), "TSS" (num),
"nTAGs" (num), and "strand" (+ or -), corresponding to the sequence
identifier, position, tag count, and strand,
respectively.
}
\description{
An internal function, invoked via processTSS, that creates an
expression matrix for all TSSs within a given TSS experiment (in slot
tssTagData)
}
\keyword{internal}
