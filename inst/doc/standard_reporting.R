## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(eudract)
library(knitr)

## ----safety-------------------------------------------------------------------
head(safety)
safety_statistics <- safety_summary(safety,exposed=c("Control"=99, "Experimental"=101))

## ----group--------------------------------------------------------------------
df <- safety_statistics$GROUP
names(df) <- c("Arm", "SAE count", "Non Serious AE count", "Death from AE count", "N", "All cause deaths count")
kable(df, caption = "Total Adverse Events")

## ----incidence----------------------------------------------------------------
incidence <-  incidence_table(safety_statistics, type ="serious")
kable(incidence, caption="SAE incidence")
incidence <-  incidence_table(safety_statistics, type ="non_serious")
kable(incidence, caption="Non-serious AE incidence")


## ----relative_risk------------------------------------------------------------
rr <- relative_risk_table(safety_statistics, type="serious")
kable(rr, caption="SAE relative risks")

rr <- relative_risk_table(safety_statistics, type="non_serious")
kable(rr, caption="Non-serious AE relative risks")


## ----dotplot_sae, fig.cap="SAE", fig.height=8, fig.width=8, out.width="90%"----
dot_plot(safety_statistics, type="serious", base=4)

## ----dotplot_ae, fig.cap="Non-Serious AE", fig.height=8, fig.width=8, out.width="90%"----
dot_plot(safety_statistics, type="non_serious", base=4)

## ----dotplot_edit, fig.height=8, fig.width=8, out.width="90%"-----------------
fig <- dot_plot(safety_statistics, type="non_serious", base=4)
fig$left.panel <- fig$left.panel + ggplot2::labs(title="Absolute Risk")
fig

## ----dotplot_save, eval=FALSE-------------------------------------------------
#  temp <- tempfile(fileext=".png")
#  png(filename = temp)
#  print(fig)
#  dev.off()

