#  ------------------------------------------------------------------------
#
# Title : Import double lecture experts
#    By :
#  Date : 2025-09-04
#
#  ------------------------------------------------------------------------


library("tidyverse")
library("readODS")
library("janitor")
library("labelled")
library("baseph")
#
tt <- read_ods("./datas/doublelect.ods", na = c("", " ", "NA")) |>
  clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(relecture = as.factor(relecture))

bn <- read_ods("./datas/doublelect.ods", sheet = "bnom", na = c("", " ", "NA"))
var_label(tt) <- bn$bnom

tc <- read_ods("./datas/technique.ods", sheet = "techniques", na = c("", " ", "NA")) |>
  clean_names() |>
  mutate(across(where(is.character), as.factor))

bn <- read_ods("./datas/technique.ods", sheet = "bnom", na = c("", " ", "NA", "Non interprétable, nerf non allongé"))
var_label(tc) <- bn$bnom

save(tt, tc, file = "datas/dlect.RData")
load("datas/dlect.RData")
