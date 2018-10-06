## ----eval=FALSE, message=FALSE, warning=FALSE----------------------------
#  devtools::install_github('fengye0907/LAB5C',build_vignettes = TRUE)

## ------------------------------------------------------------------------
    library(LAB5C)

## ------------------------------------------------------------------------
example <- geocode_f$new("Stockholm")
example$getCoordinate()

