% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eudract_convert.R
\name{eudract_convert}
\alias{eudract_convert}
\title{applies a conversion using xslt from a simple xml file to a eudract compatible file, and checks against the schema}
\usage{
eudract_convert(
  input,
  output,
  xslt = system.file("extdata", "simpleToEudraCT.xslt", package = "eudract"),
  schema_input = system.file("extdata", "simple.xsd", package = "eudract"),
  schema_output = system.file("extdata", "adverseEvents.xsd", package = "eudract")
)
}
\arguments{
\item{input}{a character string giving the file path to the simple xml file}

\item{output}{a character string naming the output file}

\item{xslt}{a character string giving the file path to the xslt script. Defaults to the script provided in this package}

\item{schema_input}{a character string giving the file path to the schema for the simple xml file. Defaults to the schema provided in this package}

\item{schema_output}{a character string giving the file path to the schema. A copy was downloaded and is provided in this package as the default.}
}
\value{
the output from the validation against the schema. A new file is created as a side-effect, which is suitable to upload into eudraCT.
}
\description{
applies a conversion using xslt from a simple xml file to a eudract compatible file, and checks against the schema
}
\examples{
safety_statistics <- safety_summary(safety,
                                    exposed=c("Experimental"=60,"Control"=67))
simple <- tempfile(fileext = ".xml")
eudract <- tempfile(fileext = ".xml")
ct <- tempfile(fileext = ".xml")
simple_safety_xml(safety_statistics, simple)
eudract_convert(input=simple,
                output=eudract)
clintrials_gov_convert(input=simple,
                       original=system.file("extdata", "1234.xml", package ="eudract"),
                output=ct)
\dontrun{
  # This needs a real user account to work
  clintrials_gov_upload(
    input=simple,
    orgname="CTU",
    username="Student",
    password="Guinness",
    studyid="1234"
    )

}
}
\seealso{
\code{\link{safety_summary}} \code{\link{simple_safety_xml}}
}
