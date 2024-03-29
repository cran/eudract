% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/incidence_table.R
\name{incidence_table}
\alias{incidence_table}
\title{provide standard structured tables to report incidence rates of AEs by arm}
\usage{
incidence_table(safety, type = c("non_serious", "serious"), percent_round = 0)
}
\arguments{
\item{safety}{an object created by \code{\link{safety_summary}}}

\item{type}{a choice of "non_serious" (default) or "serious" as to which type of AE to report on}

\item{percent_round}{integer giving the number of decimal places to round the incidence
percentage. Default of 0. Maybe you need more if there is a large sample size 
and a rare event of interest}
}
\value{
a data.frame that can be directly printed as a table to a report.  Each arm has its own column
and the text contains "p\% (r, o)",  where r is the number of participants with the term, 
o is the number of occurrences, and p a percentage of participants with the term.
}
\description{
provide standard structured tables to report incidence rates of AEs by arm
}
\examples{
safety_statistics <- safety_summary(safety,
           exposed=c("Experimental"=60,"Control"=67))
head( incidence_table(safety_statistics, type="serious") )
}
\seealso{
\code{\link{safety_summary}}
}
