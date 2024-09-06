#
#
#
#
#
###################################### R ######################################
library(tidyverse)
knitr::opts_chunk$set(warning = FALSE, message = FALSE, fig.align = "center")
###############################################################################
#
#
#
#
#
#
#
#
#
####### ### ### ### ### ### ### ### ### ### ### # R  ## ## ### ###############################
library(tidyverse)
pgroup <- 1:16
females <- c(
    18, 31, 34, 33, 27, 33, 28, 23, 33, 12, 19, 25, 14, 4, 22, 7
)
males <- c(
    11, 22, 27, 29, 24, 29, 25, 26, 38, 14, 23, 31, 20, 6, 34, 12
)
table_data <- data.frame(pgroup = pgroup, females = females, males = males)
pander::pander(table_data, col.names = c("Progeny Group", "Females", "Males"))
###############################################################################
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
