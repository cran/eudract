## ----meta---------------------------------------------------------------------
subjectsExposed <- c("Control"=99,"Experimental"=101)
#count of deaths not in the Safety data. Could be c(0,0)
deathsExternal <- c("Control"=3,"Experimental"=5)

## ----input, echo=FALSE, results="asis"----------------------------------------
library(eudract)
file <- utils:::.getHelpFile(help("safety"))
tmp <- tempfile()
tools:::Rd2HTML(file, out=tmp)
out <- readLines(tmp)
headfoot <- grep("body", out)
cat(out[(headfoot[1] + 1):(headfoot[2] - 1)], sep = "\n")

## ----counting-----------------------------------------------------------------
safety_statistics <- safety_summary(safety, 
                                    exposed=subjectsExposed, 
                                    excess_deaths = deathsExternal, 
                                    freq_threshold = 1
                                    )
safety_statistics

## ----xml----------------------------------------------------------------------
simple <- tempfile(fileext = ".xml")
eudract_upload_file <- tempfile(fileext = ".xml")
simple_safety_xml(safety_statistics, simple)
eudract_convert(input=simple,
                output=eudract_upload_file)

## ----check_schema-------------------------------------------------------------
myschema <- xml2::read_xml(system.file("extdata","adverseEvents.xsd", package="eudract"))
aes <- xml2::read_xml(eudract_upload_file)
check <- xml2::xml_validate(aes,myschema)
if(check){print("Validation against the schema has passed!")}

